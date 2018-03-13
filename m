Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtPIIke1qZuVPncGrceirrjeQ/dHwd7OecXrHHCEBTaGFJoZuFlDNQbt3S/+dgNjvC7NmAp
ARC-Seal: i=1; a=rsa-sha256; t=1520955220; cv=none;
        d=google.com; s=arc-20160816;
        b=WZ5z5ojLtI3CCBMnUVYc/NCwnlKwqs8PsWwP0AHQkNKEGITa2NI+bXExeK4x1zlNeS
         nlEgoAxvZ5GuJZ0Qotm1+tpUMpaFfPPO8SzwjO6nrwoRMxQ4MdboujeaMiC3gfLRysPM
         i/2cEIfPG7JHHamAfQ3HiatnzXui9n/Y8aafjcxs5+uFLxygsxoFWT3gNH9FeHv4Epvk
         wBwTRfR+hrTw5Ercb8X9/xVWOWtJyjcKKaJOnMT3egxzm4frJX4PyT8E4UjKQGqOnrht
         FrM3RYLHHrZVEm9kCEl+BZVhy6HMs75ieV/JkWE6py1e06Kdh0vu22GBV8h06UEXVN+H
         y22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8g9IM5QgRd9b0xIzac/UURQBwb3fh6jOg5rPfgV/F6g=;
        b=bwXhVETmXOwB6jKmfxe1NprY392fJqTFFgV4RWoW26vvMlZXRByJTESNaRLYNBuwgF
         94Qqxsao/WdZpa89C9lQLxXXbaRdkVHaKanmoFOQmQwJtDu5ujlvx/mCapmL3Qn2MqH/
         A2wllAeEeJUZd9a7qouQHfyrurUPTU/+FI4mXpb7Y2QiEI6iZMTexNOOtL6x/QIBVf54
         mhmGmmSDJgGzcjMp8lNiVethCaKt0UsjdHAFXthxMlLxiju9+nocGLxtMf8MxkKqp/ft
         1vLSdf020uUmUnlzxssoczl+pVRUw8S0yhxvkMugbgdJFvIBoXGKXZlRDhJ0mqLHWpfZ
         25kA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.15 104/146] watchdog: hpwdt: SMBIOS check
Date: Tue, 13 Mar 2018 16:24:31 +0100
Message-Id: <20180313152328.482148900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837141192924323?=
X-GMAIL-MSGID: =?utf-8?q?1594837141192924323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Hoemann <jerry.hoemann@hpe.com>

commit c42cbe41727a138905a28f8e0b00c147be77ee93 upstream.

This corrects:
commit cce78da76601 ("watchdog: hpwdt: Add check for UEFI bits")

The test on HPE SMBIOS extension type 219 record "Misc Features"
bits for UEFI support is incorrect.  The definition of the Misc Features
bits in the HPE SMBIOS OEM Extensions specification (and related
firmware) was changed to use a different pair of bits to
represent UEFI supported.  Howerver, a corresponding change
to Linux was missed.

Current code/platform work because the iCRU test is working.
But purpose of cce78da766 is to ensure correct functionality
on future systems where iCRU isn't supported.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -700,7 +700,7 @@ static void dmi_find_icru(const struct d
 		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
 		if (smbios_proliant_ptr->misc_features & 0x01)
 			is_icru = 1;
-		if (smbios_proliant_ptr->misc_features & 0x408)
+		if (smbios_proliant_ptr->misc_features & 0x1400)
 			is_uefi = 1;
 	}
 }
