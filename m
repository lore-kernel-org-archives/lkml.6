Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpHXRmVy9U3uY3Ec6Y0Vq6V12fwz0EMwAKGBWiBwJiN+2xPlQYe6aYW7kmeoLmwjhk4UNWn
ARC-Seal: i=1; a=rsa-sha256; t=1524837785; cv=none;
        d=google.com; s=arc-20160816;
        b=ASky28llfYUGhAWCb7/tUoF6Sv2092BfAAkhxOmWIfTCursEB8xQZg/u4FIZeLxSvs
         57KH0J9+ywBX/w6M+kD5MsEacttDXr63Xnu8hsDk2qdxktkTPQFhf+qsIXIiN/2TN0S7
         tS9B2ob485aK4f84HGtWBoPwTl4+Jl0WHkWOkQFzH0nnE+c/LwiO4GrZ/FYXnlYVVj80
         YuLbIz1fVtSCTkupHKPt1l/HSrsclw4GYddjE+oTqhBdNstxnMlJGxPjzyWEd2FovfK1
         Y1xkEX4Wl3LnWfy+LntV9DMQ8XcfrZ38n0VN6zXV/u1v+AlN/fjlXG1NyjDoDoicQCUd
         7PJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Dt+TvaoN/FvIC2XLnCz+0QzthkqDck3M8A88boPrsmo=;
        b=htIFyBLpSGeQ5AHhO+SykSR1tcFYZYZrIU4fReLsJhrx5GOVt9QAOxszL7HvmLk3rp
         9pY6hhTEAmnTKZQRVo8p5Q9iL2AHayEzXwOMz0VKqeEmrtqFA4AZpxl6XHQQ8GZHIW7E
         HXS0tn32BOR3oaaqSlKCyTLVO1FTLnJupga7xGHdViY94wJLVVNAnHEVPZ/ivEo8olrO
         qP6XXofxNgmcIwSk9OD9xsNVi6m/j4O0KrN2md7mrrVVPr4dAHjrlJWsbEhPsbePar5n
         3XXI1TEmjFIAeNZV9ojh1ZMic8kHl9oz+sjRMULhguH4W6Ci2rtS4rzv5dU+vVbXjZbT
         tY1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB4B218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jason Andryuk <jandryuk@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.9 06/74] i2c: i801: Save register SMBSLVCMD value only once
Date: Fri, 27 Apr 2018 15:57:56 +0200
Message-Id: <20180427135710.160649821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908305930801008?=
X-GMAIL-MSGID: =?utf-8?q?1598908305930801008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -963,8 +963,6 @@ static int i801_enable_host_notify(struc
 	if (!priv->host_notify)
 		return -ENOMEM;
 
-	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
-
 	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
 		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
 		       SMBSLVCMD(priv));
@@ -1603,6 +1601,10 @@ static int i801_probe(struct pci_dev *de
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	/* Remember original Host Notify setting */
+	if (priv->features & FEATURE_HOST_NOTIFY)
+		priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
