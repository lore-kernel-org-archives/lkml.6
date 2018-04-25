Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/7ojB+ls93904pFfCFX03svjwHRevgOYlmStLLM00nn5/IDWODR/krYWcq3ftQsit0Rb8
ARC-Seal: i=1; a=rsa-sha256; t=1524652695; cv=none;
        d=google.com; s=arc-20160816;
        b=ccHpnJgNce0encyqhv62ufrn8GenoIr3lHAYqHFqmV9LZ2smGf9HKN/4E/L2VUia/x
         csd6gurj8ow9LFqZh3wgJ6pBoOfevyhbnf4W0obsMUakNMjedAVOkyvQGaF1LtQh5GSm
         fOsYNxb4bJJdLHQzl40UUsKyV5vx3+g1Q9laDBKoHD2r7lSK08rgKdxGpQ5o9URHxLGt
         SlgDVMkBtrtHBLCgsF7MmqX+J7SfrgTEnkCE/yC+9YqcMR7rKc3OVToVzHP4OPXI5K4l
         qZE3xsHpwpghgpkya/1KoEptX95FI5LUQLcSydNsX+JDYrHzAm1tGCWr8ykBCK0JH448
         XYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZDyjofpxS2kCWElhh/Jr9Q325T9i30T1iyaxVbaCoMc=;
        b=0o1f6oLxmJ++AyiKhfsTvN80tntLuTG94sGjnZXqshGaTnGysvfoH/M4WXzOy0+4kt
         Ohxok780tSdxWCMnLm61bIME9pDgp9cLxddQ/TKR0jLZzs00+DMoTtJpIqZ8qhXTqmf0
         LtPa31p1mKYVXLNHmUj4lJTvHvx/8YC3rRf10TeUzICbJdVham6WayBRL0WkQ/UeilqX
         BbkBScp+mKYHbLvydJjsiK+iznA+wOzCHQLG5LHLcnuM3V7wDVvdNS8hr3eixlvzyFfR
         7lCoIpriepWMsFbOFoo02ZVh7fopYkrDlso1h8JdHkEkHbxhUo3fiwneqd0zBoI8ueXN
         EKxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 036/183] i40iw: Zero-out consumer key on allocate stag for FMR
Date: Wed, 25 Apr 2018 12:34:16 +0200
Message-Id: <20180425103244.032341402@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714225194174709?=
X-GMAIL-MSGID: =?utf-8?q?1598714225194174709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit 6376e926af1a8661dd1b2e6d0896e07f84a35844 ]

If the application invalidates the MR before the FMR WR, HW parses the
consumer key portion of the stag and returns an invalid stag key
Asynchronous Event (AE) that tears down the QP.

Fix this by zeroing-out the consumer key portion of the allocated stag
returned to application for FMR.

Fixes: ee855d3b93f3 ("RDMA/i40iw: Add base memory management extensions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1656,6 +1656,7 @@ static struct ib_mr *i40iw_alloc_mr(stru
 		err_code = -EOVERFLOW;
 		goto err;
 	}
+	stag &= ~I40IW_CQPSQ_STAG_KEY_MASK;
 	iwmr->stag = stag;
 	iwmr->ibmr.rkey = stag;
 	iwmr->ibmr.lkey = stag;
