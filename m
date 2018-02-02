Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225RCcsb4YSy6gP8aVZ8Y57AqnjDUSx4HOHIp6pxpkWalbrMsWBdmtWVDloGjFrcZ16Cb9kH
ARC-Seal: i=1; a=rsa-sha256; t=1517591394; cv=none;
        d=google.com; s=arc-20160816;
        b=pwR4F0iOW/kbSpfZgU7E6zjpEzEeIQLSkm1nHn6OHEf9RRcR0sYVzCMx89sATbYbgl
         0xDxqTZfwuFx1f5O0P6dYLWIOW5cW4fAWIAGnPItXzURuqv34kj+nCCCgzTijVfS4GjQ
         MnvdhheTq7VBzYh8wgNdH8w9Oek8xfapUY62oT1Scq+Ymk4gqeVpf0AdQfj2j8lGV8SJ
         DoeYuhRQF/HA2cu6hvkry7cSPtJGaFSaa1gT0ZxVfghEGuj5nSs06Dpd1MsxHapIClwe
         UWzbgItqcwepHxX2NeMcQ6B8Kc2g8eIb5OCCgu/5GAEFEiR/4e+IZr0wBpq6lY7nQA5M
         5ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DQ+WOz20vyfgn2TSDdE9lByTJzXNn94qW0H1OOXMfuU=;
        b=UVe8snMvBtmEgQipvCFwNwHkfqxhCH0EHeAaWnXf0jjhkGX/QPZTFK87PhgXiB5GUH
         exE6V3lPGp9FSr+3BN0DUFfBh1Eqa9Lfgt3t8rBQGzjQjPK+FZLs4CMUDkEjWmdTwMm4
         43voKZGJp0zls/93TV/Utci/O5OQ0T5dvdHuXi5e0B9vd6juFT0rjTc3GMZbJilDhHYj
         D57cWhlcp4a+Flu82m88tlmdE7Fms0wQVssNDDkLpigRNAYAnMmSsPdx5fW9XcIhHo52
         9wIpZ42qOamjv22tctyxcd1SyLzYaR3uvNJJVhBU8o/pV6Zu8y/zj6rbTQIFEBU6kpp/
         g7Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	shaoyun liu <shaoyun.liu@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 063/156] drm/amdkfd: Fix SDMA ring buffer size calculation
Date: Fri,  2 Feb 2018 17:57:24 +0100
Message-Id: <20180202140843.143873811@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309434338895990?=
X-GMAIL-MSGID: =?utf-8?q?1591309914543319796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: shaoyunl <Shaoyun.Liu@amd.com>


[ Upstream commit d12fb13f23199faa7e536acec1db49068e5a067d ]

ffs function return the position of the first bit set on 1 based.
(bit zero returns 1).

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -205,8 +205,8 @@ static int update_mqd_sdma(struct mqd_ma
 	struct cik_sdma_rlc_registers *m;
 
 	m = get_sdma_mqd(mqd);
-	m->sdma_rlc_rb_cntl = ffs(q->queue_size / sizeof(unsigned int)) <<
-			SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
+	m->sdma_rlc_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+			<< SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
 			q->vmid << SDMA0_RLC0_RB_CNTL__RB_VMID__SHIFT |
 			1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 			6 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
