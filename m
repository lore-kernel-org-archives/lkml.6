Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsyDuTWt5g0K7FkGZyZ85UHsEPap9lCyJxsAjdrorxv6pSsclKVdHnsvzGxi/h3G8N5ht6o
ARC-Seal: i=1; a=rsa-sha256; t=1520451638; cv=none;
        d=google.com; s=arc-20160816;
        b=Qp0lFRUw4LxIQcN/mJsR2W29XBzM1gwoYcXrVglFbY4u5frSrpXLi2qSv+aendJltL
         mIgIhBsnB9bGdvQZt7UMuDdCl3yN/aNzJ/wRb0k+jXCUEAvnbxtagOYW0fcY9LXr3kOb
         c19u6hRRn7gZ+H7BM+7n0vceqdG8sdVADqB2Zwm92f+9BNqBYQb6uE/IGuevhFqOHMpN
         WJfeda3ATx0pXsoINywjfMtg3LkKXTAiYSezebZ6gmDGnvQf2SKLiZ52wAR04tyJNzqE
         KONsoK4eD3A5IM0ryFCVXPbDMYuqyZm5Hasbrdr/3g12xPtP7XXGDcpEKGNYyjudrvnV
         E2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vo6M/FOAc00sFacV3l/zERISB+Gtek+6pzBhj7cg5HM=;
        b=vpockRq7zQ+jGZpclpp7SMRNETPSW3ZclHNZayugKUStgTQzzVxzCI0hepByqiw6/V
         RUNQqOCslZQHuI+y6I0TuNbhxnDZpeJV+dCCBOKh03TLuZVHUGgxxYbKlxuioT8B3p1S
         Cs1OYvJllupbbTMEt4zvgrQZG9QNQ1lakCgSnCY3dTNfOewHLU0EzGcP3Yc8+1t1DhQX
         s39VV8e3Xrz5z70kplM5tbKJA2KzleGYO+MvJ8V5YXog7pqJdMDXG7sSTBPx90F/RUXI
         y92xQr2tlqi296x9MUNqfgejHWiaZ/IIgYAMJKXRtbw11Kbsgu3avK3T70nONbV63aFx
         J5yQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Omar Sandoval <osandov@fb.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 030/122] block: kyber: fix domain token leak during requeue
Date: Wed,  7 Mar 2018 11:37:22 -0800
Message-Id: <20180307191733.615969763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309097020777218?=
X-GMAIL-MSGID: =?utf-8?q?1594309097020777218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit ba989a01469d027861e55c8f1121edadef757797 upstream.

When requeuing request, the domain token should have been freed
before re-inserting the request to io scheduler. Otherwise, the
assigned domain token will be leaked, and IO hang can be caused.

Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/kyber-iosched.c |    1 +
 1 file changed, 1 insertion(+)

--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -833,6 +833,7 @@ static struct elevator_type kyber_sched
 		.limit_depth = kyber_limit_depth,
 		.prepare_request = kyber_prepare_request,
 		.finish_request = kyber_finish_request,
+		.requeue_request = kyber_finish_request,
 		.completed_request = kyber_completed_request,
 		.dispatch_request = kyber_dispatch_request,
 		.has_work = kyber_has_work,
