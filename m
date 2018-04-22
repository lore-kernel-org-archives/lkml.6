Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5Du/KknY0XNZHu4qDLINFViK0jeZ0YYdCp7flpiJNfBFzKgYuhKdamThGjcaTSvde7XQK
ARC-Seal: i=1; a=rsa-sha256; t=1524406042; cv=none;
        d=google.com; s=arc-20160816;
        b=wC/K0g5LtydqIg8nTS+FPJDW1yMLYNYSutD5fvdGqd9v1jR5SAjnYdfjinqZ1GcRlH
         VZPuT42Llk9+xuQAXmLcONwbbN4WNHfgMvD5EFVhgawPnp8ACMaGGPmfW9iDaNNcEgN7
         4gmmrri666sl4dCVctKbDn51/L6WtRmmJGFECXAQr77Xft709/VA7RGahTbfGFCYP89s
         J/a6U2A252itS7/bYa8gaEPfZKDz6jWb0CbBl28EiBizP/9LkUxTJUVPUnMdQB9/FMOZ
         bJDqgp/UI3KpOpEhnBbeze3ixfkgZE93PLivFFN/8KN88mH7D3JwLin1eA0+LfA/ss2z
         iHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oNQhO1lfr1LkFdAZ8RhgnIF68l6JVgGMnAIRCApCFnc=;
        b=G7CCQIwZ/AZsZq6dFCwYn/X0FrmABRTu4x3ga2p5uPc45DlkhfeveeKCovLId0+vpR
         naO/KAxsJ2jYXii8237Z3bWwh/6m4EkjqCO1QnFihgVlldO+68boBeBZ8cN/dtZbyYhP
         FCH4l9QGcRZzwZpxN/2kDoNJzeG6Ce69JL4oFi4pg/NB3o4y4vHkquTtOyYvZkRDcg2+
         +TfrpYvVf5wDiere4d65qMs5r1HWexeZArMX7s3tm6+eMagEneKwgIabNIjkSnBvvSrY
         2/JqLE84yTD/kI1iHQWLd9HZ2Ab+Ny1HQwcPxdMX1inZTXq9dYCBcK9PnwqzrWXGSOrf
         Fisw==
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
Subject: [PATCH 4.14 091/164] IB/srp: Fix completion vector assignment algorithm
Date: Sun, 22 Apr 2018 15:52:38 +0200
Message-Id: <20180422135139.153369113@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455094734674658?=
X-GMAIL-MSGID: =?utf-8?q?1598455590458126795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3430,12 +3430,10 @@ static ssize_t srp_create_target(struct
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
