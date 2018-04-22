Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3tB40DYnWYddw3A14bpwdjm+xwWu+dVmBYvCWz1sjwR5Zn1gVhAyLH/A/1JiponGxj33z
ARC-Seal: i=1; a=rsa-sha256; t=1524405397; cv=none;
        d=google.com; s=arc-20160816;
        b=L2/47F7YXSWfvAvgnbZwsGoUNCrtQpsf4i6/32tuXh6WPeJp6x5ZetvaBKZ3N2/swL
         kAN2mpaUBDkvPU0ztgDrom9EypffCjyrQ1qkRa/1gzWDXZPKH3WISt4llN1jkZhJ/3Cp
         aooY2SFZFaBCBcudQaEJKR0JDYcqZMMcrYGhOkW9pEstoc+6b7BOp/3WSw7FXRGOf18i
         FNA/Z0kZ7223JQe2iw1ma37zzrtTqibGww8AieDkb/Xc+tDtDpOIbs5HhW9dUKxnLiqH
         cpfInV0Zabv04gf6wT8KsI5DaE+4dUeEwDvoQQ2UIKuJD0XwjX7xHGdLCVvd36wRWbJ7
         drwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4J4Ne2YKCfvKzEupCinaEz/oSYn5aNLBcDgzBYtJtYI=;
        b=n1SRlIS0nz6z2nDfEID7A8EDFrbl3+434vu9PzdY/xrgNc3gnVQYNwH6ph62564/Fc
         2b6PBfKcUHhUNnSTTbvBvL2W9CqW2sT50N6kANKgxD3wsnvvw0oVN9HPXnoS6uK2bSt/
         uR6FHZ3Sd0LCQada8Gs92fT9ho2vujdY0VGr6zDghPoikl2/WxtKRGKG/61FQXT5+e9Z
         PcJkbZe1oRuvmG2Ys9RCmV6c4hVyzUJAWXsWi+CqW3TonyiIZIDk8N3mtnWxa9vGoSwv
         lbBfA9R+8AoDhitRZc9wB93bHVkb/QWmnJoLP8BkMu0ppLoc1jDqvkcatztke0rR9FVS
         AS+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jason Andryuk <jandryuk@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.16 052/196] i2c: i801: Save register SMBSLVCMD value only once
Date: Sun, 22 Apr 2018 15:51:12 +0200
Message-Id: <20180422135106.789178651@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454913621900566?=
X-GMAIL-MSGID: =?utf-8?q?1598454913621900566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit a086bb8317303dd74725dca933b9b29575159382 upstream.

Saving the original value of register SMBSLVCMD in
i801_enable_host_notify() doesn't work, because this function is
called not only at probe time but also at resume time. Do it in
i801_probe() instead, so that the saved value is not overwritten at
resume time.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 22e94bd6779e ("i2c: i801: store and restore the SLVCMD register at load and unload")
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@vger.kernel.org	# v4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-i801.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -966,8 +966,6 @@ static void i801_enable_host_notify(stru
 	if (!(priv->features & FEATURE_HOST_NOTIFY))
 		return;
 
-	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
-
 	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
 		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
 		       SMBSLVCMD(priv));
@@ -1615,6 +1613,10 @@ static int i801_probe(struct pci_dev *de
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	/* Remember original Host Notify setting */
+	if (priv->features & FEATURE_HOST_NOTIFY)
+		priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
