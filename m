Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278Yq+ji+B9QeOB8sZHCbfEbnKIX2O93emFiVMJoV+ZhO8quy1mMb8u9Xb7h4PvWx5IXiii
ARC-Seal: i=1; a=rsa-sha256; t=1517855201; cv=none;
        d=google.com; s=arc-20160816;
        b=kGsnvvAdm07cFnkN4ums3P2gfAKjP7/uJ38CmSPPQdqS1kmSZZuEbC0mpH4epS1QAo
         pPdjBKX153kFyACK0S53HJ/MidV7+1y30vF2d8wv5S7OcBlXhkKkG6UkNnGu1hrDzFqK
         iEtJj2iwqm7ZlNHxUKd+5FSkNBlnfDDzbrC2XyxeCdLAAqhxK8wfbBir3tEvazmld38z
         EbsQGEmF/hNqg+vC4w0hHeFZX+jApISnuSyrp7iSe1/AQTbwXpRqCIWwFW2iJYuqrt/m
         EgdB/FxGsCpMcbrSm+eOWgnORkpsKtOCOuJmRVopQWLbZWbBDaEgQcs2EDW3rbzmKJmK
         BGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xjRGnWgCZUNEQfGAa0EhftZ4uU6YQSnW8Z2nIY0KHOc=;
        b=T5bttJ33PSt3nllpYXPM9jHIko9xRDQGCq9KEFfFR5q9P/NA16lBf4NHEvgj0E8umc
         lVKcl9JigXU5pafN4P5zf7CEF9cmCOkv73BsZZWLAhz6wiukUltyxwKfZaBuVFDPwHpG
         Pd1uBLOKJl5MIyeUekmXhGB1D6nOkeqGwY9jVPUF5HbgWYP2awF36TVJKRRww2UinYsL
         Hpy3a80iixE9VivyvEReSN9wnePeaJvCCnDRokZ69vQt2uMhGcEFht9Mdr1hVxCLgqm8
         t59dKL8QxBcmsHt6WFymQUrf1qn14ewqmlYlwiKGoxvjpzJKPwwQ+iWT48yXiq9gRm+5
         XqxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3.18 26/36] USB: cdc-acm: Do not log urb submission errors on disconnect
Date: Mon,  5 Feb 2018 10:23:54 -0800
Message-Id: <20180205182352.852726086@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586535982943299?=
X-GMAIL-MSGID: =?utf-8?q?1591586535982943299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f0386c083c2ce85284dc0b419d7b89c8e567c09f upstream.

When disconnected sometimes the cdc-acm driver logs errors like these:

[20278.039417] cdc_acm 2-2:2.1: urb 9 failed submission with -19
[20278.042924] cdc_acm 2-2:2.1: urb 10 failed submission with -19
[20278.046449] cdc_acm 2-2:2.1: urb 11 failed submission with -19
[20278.049920] cdc_acm 2-2:2.1: urb 12 failed submission with -19
[20278.053442] cdc_acm 2-2:2.1: urb 13 failed submission with -19
[20278.056915] cdc_acm 2-2:2.1: urb 14 failed submission with -19
[20278.060418] cdc_acm 2-2:2.1: urb 15 failed submission with -19

Silence these by not logging errors when the result is -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -381,7 +381,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 					"%s - usb_submit_urb failed: %d\n",
 					__func__, res);
