Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48b8ieTeyI9EqkqZg2aFEZhiDTz0set+7ulLmlsC1aglNzr3RvJzJAKqdI+B+VOsOMRPCSB
ARC-Seal: i=1; a=rsa-sha256; t=1524406362; cv=none;
        d=google.com; s=arc-20160816;
        b=ecSqIMSFDM0HdOKO/4l+iy87UUqyqsAbbs3rA1Oe+I/OAmELUhh5XAFzIAidyn97HM
         mbkRmzb/UU8USrCLcpkBvijabfyS1xn/DygJbRO1GAP76Xq3KTied1mz0XNZy9weJXSp
         VqXNkgCUiXM5ZtyWS5l1Ipk45bvnKI24kzTHULEsmicdn0BkOjwGNtp/uWWUhYyFQXCP
         nfwQb/LsrqW3GX6kxxr65xeotRt7bD+2sP1I44yu6i5anOtNwKBNfrWyDOsC1Jh2XttA
         PixeEzYzTyxCqxeGQirETLmwRjwcexMZ8T6scg5khtOFls4qy2NnH8KCLyDEdekJb2Kg
         WegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bKFxRsXAEZKhsb/1beodyr7gU3nbFczr36mGjNiBk9c=;
        b=Z8DSyD0s+kNtRumvzn5yF7x9uqBUKUqwzIagGCZ4g1TEi9V9FLcHPeukXZ9zwfUfWL
         3M03QnfVYoXdNhqsyKkawSXK80nzStzbSZGphN3pTKGllzYfXQcrgLnFPVV3zzTQSFtN
         THeYh7ZLdUHNAoiFPeGPUA/xOwbzRGXzt5NwDLbtrDwcNjtfXA2Gev4Ut/P9Ylgv7vwr
         Lq8lN8+2jD6jGg20xCYGtz7vJDDoHfIUMMqWfCw0hzXiIPQ75wWLKtAh6w/LwSZd1eXH
         V0yAV8g9D/0kTwDAQALD+BdRURJj7ka8Nyr3aPc4r+iS9zqRD4aol0if63eEOlOCrZLB
         DgXg==
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
Subject: [PATCH 4.9 43/95] IB/srp: Fix completion vector assignment algorithm
Date: Sun, 22 Apr 2018 15:53:12 +0200
Message-Id: <20180422135212.179983678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455094734674658?=
X-GMAIL-MSGID: =?utf-8?q?1598455925871525631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3397,12 +3397,10 @@ static ssize_t srp_create_target(struct
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
