Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5TwuPpyOK+xEr+ZxVE3wFG7gpqgBujMUkfSrU+bnni2b/sTNgbUzg6n4Bj8pMlaIngC1h
ARC-Seal: i=1; a=rsa-sha256; t=1523980878; cv=none;
        d=google.com; s=arc-20160816;
        b=b2omoAKKiJKO/2rPjR5ooerYAjn3kFQaCv75hU1RzuYodHQDdirTlsfk3Zbw3fUJZ5
         cYA6Pwe+62Xy2gkNrCimHjuKch60vMN/DNmjke5DZ5PULO68M59cy+v90bIV3xG2Juv/
         q/0IRsrTthSwD0dnhtNH1E0+efxeszl98DzTn4AIkmoPyJWBaY1r5K9/yg3YoI306B+D
         bR2MBEu2gzEfXHdzjK8cYAWZzik1yrLdNqURh4+ULPAsCaDz6FIX5E7AzBaQmibrkRZf
         05kkNEu1RskUevPM0aqzmREduqxx+49aVU+6ZtxQ1SZRG7gzKn7oNUY3Ez6Yb7wsFhYj
         wQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r9dRDVxqLp/rQ9c2RS4q/WqTxOpytch3nWGFjL01Atk=;
        b=lfCGwM3dLG1yxvLxHc/wXVwZgH4Ch6tLJIMAwhuo7CAhGzsFXj1lEFbtmcgerTA28z
         AXUGsHdwWyKQ+W4XlZanbDwbGW3pPlTGDPQwIap833hvVtvlcpS7xaFTDTK8ISCp0O30
         IlE4U1m37Rs2zzeYCc4P8n81tVBTOsuUGKGoAoG0T3tzF0m673QORGoQmocTYArZsL3f
         uroyDP/i9AHoGUa31hs8LmOadbnioKvUUzqHEyUBWohawpQuB4/MRjLEfpq1R2Dy2vLR
         cxYKWu/9ssZzAcDE7xy4x81e2uaj50My4DiEhvxEBsmFbARcZexmeB0wgeYI+SJU97DU
         IkQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Gagniuc <Alex_Gagniuc@Dellteam.com>,
	Keith Busch <keith.busch@intel.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 37/68] nvme: Skip checking heads without namespaces
Date: Tue, 17 Apr 2018 17:57:50 +0200
Message-Id: <20180417155750.840111905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009773096722663?=
X-GMAIL-MSGID: =?utf-8?q?1598009773096722663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 2079699c10c8c60a9572540c2f77d045abf036eb upstream.

If a task is holding a reference to a namespace on a removed controller,
the head will not be released. If the same controller is added again
later, its namespaces may not be successfully added. Instead, the user
will see kernel message "Duplicate IDs for nsid <X>".

This patch fixes that by skipping heads that don't have namespaces when
considering if a new namespace is safe to add.

Reported-by: Alex Gagniuc <Alex_Gagniuc@Dellteam.com>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2793,6 +2793,7 @@ static int __nvme_check_ids(struct nvme_
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (nvme_ns_ids_valid(&new->ids) &&
+		    !list_empty(&h->list) &&
 		    nvme_ns_ids_equal(&new->ids, &h->ids))
 			return -EINVAL;
 	}
