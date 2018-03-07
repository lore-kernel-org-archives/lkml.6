Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvsOc5uOwCeAeQf3SVaIhgNzFCeFBZR+1CMH7MjCxQ+/++ymtINCH4TcNww+BApmNvlefK
ARC-Seal: i=1; a=rsa-sha256; t=1520451910; cv=none;
        d=google.com; s=arc-20160816;
        b=L2V7e/kgt+ReoI8DRJyFwH0zUSNZNJrJf4gXseMI3SF8F4dRkvSgu3gRhFwhyx+zI2
         wvYl3fCu0CXm4TDnS+Sh9mGf8nDkKnWtwmBZOmRLIcSRjspgLqtIaFe2ZtUF6pDbxd4E
         d/7fxAdHocLwU6/j5B1m+nWQ6liBl9ZakOZz2nopPu9IVPRUUx1ys42F4rbD5dheZ//K
         AMjg7YoXhZ91wJkKNp0rx66OGT4NpktPN6F53/h2oFRlIBKn7ByN3ixp5YNsNYAKbklh
         7g7tzmj10yjSOtVq3ItkhW8DuP06WbeJSbQ7Z6fCnvSg/3GkVF1Kes45rEmYvRiLEzI6
         h4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VAVbr0HDIyzcsb7jv54x5zX0phLc2gjjieMOzTxJlR0=;
        b=hZW+0qJ7HlhKhpt5LtRl0NIE3bLmYNK/ePnFv0PWW6N8hTaUfpWsZth6xQAc8nrnV0
         3xKMrcAyiiwtVX9dWgDV5//oSn0jlz+um0wcVWgWxUN6MKDh2YnDCOBJGb1ePjLrAIwj
         PkN2PzH9gMd9PxPS36/svY6M52xxN50yBOt6pF0670WUTD9DXOzzH1yCZtpbL4mUzVAt
         sVGxBMaoKPU63IOY08EF9oXLqGGa6tyO6h3pq2BaqiwOT5o8WzEAH4PshkPSQ5/NELkX
         KBnwY82OGZ02CceZnNuK97yKhnIARPOe+7jGX3g+3++81p1XMZ1ymQCr94zCmdurk4oG
         xsqA==
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
Subject: [PATCH 4.14 026/110] block: kyber: fix domain token leak during requeue
Date: Wed,  7 Mar 2018 11:38:09 -0800
Message-Id: <20180307191043.068755214@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309097020777218?=
X-GMAIL-MSGID: =?utf-8?q?1594309382557470332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -814,6 +814,7 @@ static struct elevator_type kyber_sched
 		.limit_depth = kyber_limit_depth,
 		.prepare_request = kyber_prepare_request,
 		.finish_request = kyber_finish_request,
+		.requeue_request = kyber_finish_request,
 		.completed_request = kyber_completed_request,
 		.dispatch_request = kyber_dispatch_request,
 		.has_work = kyber_has_work,
