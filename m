Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsIzI/2oNOkk0u2djrwAI0NliuHLrx8utyCQ24OHRYTVzi/6uadJ+SuW6eUmRssTrkq2sas
ARC-Seal: i=1; a=rsa-sha256; t=1520955427; cv=none;
        d=google.com; s=arc-20160816;
        b=YyJyxehzLLtOYkXvzGUiC0CRitIXf5VuQqN0/PDPPYk/a6Tjr2IwB8CAswXsugIBGz
         Yz/3Ybu09RD4XbYz1n0ydVCIiA7gdesYqRtL4Wb96NKHiUk2V/GLzWzwHL/UYj3GqgFq
         5otHMAGyuo7/icxzmCRn3uXwGTTScA/Um/m8decE9EdB9H+bpI5Y2XAvs1ZeLWsXMMXf
         NJb1ng6s/NsCYy81tdRaCIJhg5+jdaJQeHQ8X8lFs9XDmLaQKimMdAVqlbDDgh1KzWGO
         lDvd/P2Bmz4eg9YEqBG0feig+e8/BB4ecVVjtFwH7Ckd0jM3ebyxc0EkJJVHtwx1yD1H
         jygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rd7Oklne1YZhKYHHmZjIGoiR7d4gEQU1A39qUCYuF6g=;
        b=kucqJHvfmo4HeyjPmytNeaPjyCjzYjskfha8qQY/KKgO3JzOMoBiplMhPdQkjVUNRa
         IVDly6d1fMyQ0oY0bA7Cu5Jrff+LbQohWm1zWS+0zj/0+fo/xlq5U4MpBsD9cItTEK0y
         pP3Q7k11rct6L/e/f9Ckv07xsVq/3EQMHSU9vEWmDz2EcvWaq941jAftr0I42W6glnxk
         3XqEgfzQHapj9plUC5MYgPc6qhg1qJ/xFdZuggdLD694uxMh/eTmOJiWwqopVdggVK9U
         ze6z/KQ2KW+uAV1kpBjBDlkC5TmlM+tT4d32nTArj730mUwFiAztTBpXuBL4eNurNDv4
         rK1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 046/140] RDMA/ucma: Limit possible option size
Date: Tue, 13 Mar 2018 16:24:09 +0100
Message-Id: <20180313152501.348471825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836765809823489?=
X-GMAIL-MSGID: =?utf-8?q?1594837357631699685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 6a21dfc0d0db7b7e0acedce67ca533a6eb19283c upstream.

Users of ucma are supposed to provide size of option level,
in most paths it is supposed to be equal to u8 or u16, but
it is not the case for the IB path record, where it can be
multiple of struct ib_path_rec_data.

This patch takes simplest possible approach and prevents providing
values more than possible to allocate.

Reported-by: syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Fixes: 7ce86409adcd ("RDMA/ucma: Allow user space to set service type")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1293,6 +1293,9 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval = memdup_user((void __user *) (unsigned long) cmd.optval,
 			     cmd.optlen);
 	if (IS_ERR(optval)) {
