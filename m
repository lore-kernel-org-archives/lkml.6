Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/e4gtw6QsChXSeSMXjCLZen9VNT90a2yKa0fMaH6cv9F8oznDcoReEm6VmQ6o2VTH6QoT8
ARC-Seal: i=1; a=rsa-sha256; t=1522168731; cv=none;
        d=google.com; s=arc-20160816;
        b=Jv04rvc4aYYdVfjaOaKgi8uGON+osyF8E08XReZqcTmsSDBcTsIkUgyulNWFkPJCE4
         Y4IuYarJgi9jNz+dWaswUAMfdpvFhdBNVNwaVY3YEv0+OIKMzjJx8H32MS1/jxNr1vUm
         8A8pX4jWMpREeDfMOVvkujq6aiaYu3EypMNeDz7tLwVuaMbD3Zm/LWEZZKS0/SMijDZq
         PsiZrjY8ygfph3fZF7hP2f0MaS1VYG7XfrZ4f6HJu1+SgW4JmiIJPwFEa+JbW7v4HepD
         z6hUheoUJnHeP6ESgC8oFioUMj1X9hX7XgmJahiiNnwbJD/Do4VbTvSiJojYYpJVgHff
         uwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZI/PrHrkfT07dhHLYXuPOfbRCSYOxAVohVh3pYm3nn0=;
        b=KtSLXtxn8EaPBh8qTARRPny4nnySF43T22vUh02JmOlYYkF6hv6x3PtTTAWHoSpKHo
         1hN0Aad3s6/hIZK/yJ6ZYt4axzbmTq8utgl8n4sZmnOiq17Wq6HVCb6J3Qia5ZV6cZx4
         LzHbOsOZ7Fwsu9mQWem9ZeNFJin7l/LM19n5J4mhSMGBVa9fcQmb4pffKEtXL7kHVlDb
         A/9JTRfGlOSjzhA0E617oQo2bJa/JtJTK2YAsSzvFU8xuW+GjgQHcPBrBpK0taQSsdFG
         y+s2ZDe9nFaLNf3WSaqls0WJC9kyAv6LmgVHzPGcc0Ls0KqwgFNc/UAgo0gwLv36ArON
         dpeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 012/105] ALSA: hda - Force polling mode on CFL for fixing codec communication
Date: Tue, 27 Mar 2018 18:26:52 +0200
Message-Id: <20180327162758.364905955@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109291709874456?=
X-GMAIL-MSGID: =?utf-8?q?1596109599628791371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a8d7bde23e7130686b76624b099f3e22dd38aef7 upstream.

We've observed too long probe time with Coffee Lake (CFL) machines,
and the likely cause is some communication problem between the
HD-audio controller and the codec chips.  While the controller expects
an IRQ wakeup for each codec response, it seems sometimes missing, and
it takes one second for the controller driver to time out and read the
response in the polling mode.

Although we aren't sure about the real culprit yet, in this patch, we
put a workaround by forcing the polling mode as default for CFL
machines; the polling mode itself isn't too heavy, and much better
than other workarounds initially suggested (e.g. disabling
power-save), at least.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199007
Fixes: e79b0006c45c ("ALSA: hda - Add Coffelake PCI ID")
Reported-and-tested-by: Hui Wang <hui.wang@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -375,6 +375,7 @@ enum {
 					((pci)->device == 0x160c))
 
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -1744,6 +1745,10 @@ static int azx_create(struct snd_card *c
 	else
 		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
+	/* Workaround for a communication error on CFL (bko#199007) */
+	if (IS_CFL(pci))
+		chip->polling_mode = 1;
+
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
 		kfree(hda);
