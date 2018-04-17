Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489bh9NILpRf7hkbeKFqpKJ2YqqJJ0hwaDsiCFM5bM8nA4IvIgwkrLS9GXogdvdB1bUWShs
ARC-Seal: i=1; a=rsa-sha256; t=1523980815; cv=none;
        d=google.com; s=arc-20160816;
        b=H6LHbq54HURxGvfqN4OJZmVaHK3PtZzvYTuo02pjt3dakmfVS8sA10y40X+Yl++E4T
         eLgTBVagNoaZJnH7iGQRvkO9OZjDAGb/AIDk+nvbU0ySdHhEFKuUVHTZEdFnsp+aUWZi
         dAYhrXRNZhxCoQI2z9T3Wvi8Bo1LwBbV/2lpKuFHy5COMZWsiJgxGh0SGPMGhHnBWnuX
         JBqcg/3K8ahmGbqE2qcn20yCWiOCnDCBzzl/+PVXdjXqqyjroG3lpiZITJb0UCyAAqrT
         TpvUNUgHSU1betphF8xD71a50wRDDwkDU0AcbMaQ+i2+UNFdSNix8eTcPG7qXiVEV+Fi
         DSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5oK+oxHz2M8ch8FlAU96Py5cAmM81GjgT5r3G85fKX4=;
        b=l/nOTQDnhOj4wnw7XA/3z6BBrD/TnafX1T+1JX95IQzAU85iAQq6VQIYpFIscibafC
         ZaI/LTSi166OCwKEOPh8vxBMl5m1BCGkw67LFT+/m4jrttIA7rky97x/210xjhxFyv4C
         cAcKVK1zhYznoFeKOZdOvCIICoqWjBad+sMnAkZSCfoKekMlq7T9lsOt6JIp122T+xF2
         jy7G7BX62ZghIwoXl1lqhMk8QOdMrSkd+z+f02ujd+1sSLFoPKzllYBtQw8bK6Wk6Oey
         9Da0voqdSP37qiyLd0uQEEIDodlXpuY6khokrCq+ZLqXqvYDAZNL989gfsLBrGgvD81k
         uoqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.16 15/68] parisc: Fix out of array access in match_pci_device()
Date: Tue, 17 Apr 2018 17:57:28 +0200
Message-Id: <20180417155749.950091084@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009707455572846?=
X-GMAIL-MSGID: =?utf-8?q?1598009707455572846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 615b2665fd20c327b631ff1e79426775de748094 upstream.

As found by the ubsan checker, the value of the 'index' variable can be
out of range for the bc[] array:

UBSAN: Undefined behaviour in arch/parisc/kernel/drivers.c:655:21
index 6 is out of range for type 'char [6]'
Backtrace:
 [<104fa850>] __ubsan_handle_out_of_bounds+0x68/0x80
 [<1019d83c>] check_parent+0xc0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019d86c>] check_parent+0xf0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019d938>] descend_children+0x4c/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019cffc>] hwpath_to_device+0xa4/0xc4

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/drivers.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -651,6 +651,10 @@ static int match_pci_device(struct devic
 					(modpath->mod == PCI_FUNC(devfn)));
 	}
 
+	/* index might be out of bounds for bc[] */
+	if (index >= 6)
+		return 0;
+
 	id = PCI_SLOT(pdev->devfn) | (PCI_FUNC(pdev->devfn) << 5);
 	return (modpath->bc[index] == id);
 }
