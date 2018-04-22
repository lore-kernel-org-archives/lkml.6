Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dR0xqEyKrHF86oZDW77zZzEbAzyj/gL1DvzpQfOqRC2XBiYijnNiefE5E4YaUK/c2WzcP
ARC-Seal: i=1; a=rsa-sha256; t=1524405569; cv=none;
        d=google.com; s=arc-20160816;
        b=nqnkX9hM5CVQHwj9W0ztGoSuqB2tRwkmsIlLskukbTOa64C4PfCKis2F1qKTDKFo7w
         ZEwtEOXkROOTjxywJUh0pBPfczHiPe3FLfjVgg+Oxlz+P5DvDrLRYrw3IJzZj0YWixsd
         BHKz5l4U/9IYBHg0FfIoiCWFW1X4YWt7A1PpfBnxwOPlBiGWo/OOOUdhYNauS0NPgnGj
         OPS9px0I81eTyGMJoDJXvGDxOuc2NT/ySBYEnZiu3soHQisSC9exhc0xPKZlr/4wtdTo
         EwftNitWmavkJn7EFvXIIMktw+msW54Rn+UPAKAb0EX/ZAk3BzfeyF5FWU0sEdOTFhWb
         m+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U2TE7vz3kBaIkW7ihG5DMuld09Sg/YgUxa4IbtjtANI=;
        b=QHNnsJwnT5MUC2RLRj+XDXGK954AmvpCCvLjlbjByouIkyzg2Ygwa/ogQq1ZQEgylc
         mBLiSOFlVgSM/cdRfa2QZ8hgzzOtu0znmCIuMtPTq21gjawjZVPFgA8JS9qo5Ihp9jmX
         dfLbFQM3HyiXLl20wP2EMZB7vBfkddu3wNHnZbs74x7e5C7H1HqocMi9P8eo99R8pLuv
         p1nHvaAlc5Bm0rAfJCCPb+lGF/NEY1wVSpbOeyVQoA5YTu2VMAIfB3fO8sb4bRkG8ovr
         +G0BDcOj3FNuZCqm+swx368IgEe9mT0A1GmnutIOgIIs7eiKxQWhY2ZABoxeDDSRd+/q
         upFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Schmid <alex@modula-shop-systems.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 114/196] IB/srp: Fix completion vector assignment algorithm
Date: Sun, 22 Apr 2018 15:52:14 +0200
Message-Id: <20180422135110.157517256@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455094734674658?=
X-GMAIL-MSGID: =?utf-8?q?1598455094734674658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 3a148896b24adf8688dc0c59af54531931677a40 upstream.

Ensure that cv_end is equal to ibdev->num_comp_vectors for the
NUMA node with the highest index. This patch improves spreading
of RDMA channels over completion vectors and thereby improves
performance, especially on systems with only a single NUMA node.
This patch drops support for the comp_vector login parameter by
ignoring the value of that parameter since I have not found a
good way to combine support for that parameter and automatic
spreading of RDMA channels over completion vectors.

Fixes: d92c0da71a35 ("IB/srp: Add multichannel support")
Reported-by: Alexander Schmid <alex@modula-shop-systems.de>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Alexander Schmid <alex@modula-shop-systems.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3873,12 +3873,10 @@ static ssize_t srp_create_target(struct
 				      num_online_nodes());
 		const int ch_end = ((node_idx + 1) * target->ch_count /
 				    num_online_nodes());
-		const int cv_start = (node_idx * ibdev->num_comp_vectors /
-				      num_online_nodes() + target->comp_vector)
-				     % ibdev->num_comp_vectors;
-		const int cv_end = ((node_idx + 1) * ibdev->num_comp_vectors /
-				    num_online_nodes() + target->comp_vector)
-				   % ibdev->num_comp_vectors;
+		const int cv_start = node_idx * ibdev->num_comp_vectors /
+				     num_online_nodes();
+		const int cv_end = (node_idx + 1) * ibdev->num_comp_vectors /
+				   num_online_nodes();
 		int cpu_idx = 0;
 
 		for_each_online_cpu(cpu) {
