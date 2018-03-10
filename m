Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuj77/jFJ97NTvOqVWfcZ9SYLw/MED2qLfXkXdOTHc/THZ0NoEXRmlPpzOJHoCLxI8thW5p
ARC-Seal: i=1; a=rsa-sha256; t=1520641349; cv=none;
        d=google.com; s=arc-20160816;
        b=xUVBcwcc4WuY/ziJxvCJzwY5VgXJ4QetvUIWawC85ySw9gY0ew14/5dzr5ylbbQLcL
         5AhTerOiU6re8msSTXL8gDBEpSAWh1NB/XVzQG2abK216clt0PNEY2ht9LQpRLYDB1pQ
         zSk4FOIIDBsXK7S826nUuNrpgVhqX4htVR4YlkXNzvitbiOxArZQS1gcwJNkO2vqW3rP
         nQMC24B6RbaB9n2cs6+cnbiLAgKmFUv7tyMklw9GRJ9rcs3H0asa7A3Y5+M626rg9G79
         5WQiBulDmCEduhMxMYePLYO3LG5fevU8qe1UVYKZLfb0Dz5jKxWKdU3/Uga6dj0PLa7w
         JItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=absro0RkSog9yMA89twv/0iBSSkDf2iWhLfyB2NEAZw=;
        b=syL44hLllqhx2mdW+MiIjj+CoSY3TXUlYt9ijwRBrwG1KjGxkDbCup93Kd+dG1eHeM
         99PA+6eiJSG77Mgc7w1hDI0ywHYuk1OZT2G0cVHh1DvMJx4c/Y315xEspxYc5iQPizug
         +dEFBPDvO0Ykz3B6u61xywQkmVXdDPWOC71nD/PyYpX+mWpOSl0k/8W5IxDvDg6aNhcA
         a8rxnMEfQDVLTC4FaF3RBA72PLSZGKl863Jcuhu2mh9X5AMK7x0hEgEoiONF6ZzXOwWr
         GhQTeaJ6bb/hA2q68E6mgQAMm6Z2IVl6s5/c2lgzLLAX7/ZzWZqpDIC8bJw+1cMf26QF
         BiSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 51/65] s390/qeth: fix overestimated count of buffer elements
Date: Fri,  9 Mar 2018 16:18:51 -0800
Message-Id: <20180310001829.079631694@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508023676080133?=
X-GMAIL-MSGID: =?utf-8?q?1594508023676080133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 12472af89632beb1ed8dea29d4efe208ca05b06a ]

qeth_get_elements_for_range() doesn't know how to handle a 0-length
range (ie. start == end), and returns 1 when it should return 0.
Such ranges occur on TSO skbs, where the L2/L3/L4 headers (and thus all
of the skb's linear data) are skipped when mapping the skb into regular
buffer elements.

This overestimation may cause several performance-related issues:
1. sub-optimal IO buffer selection, where the next buffer gets selected
   even though the skb would actually still fit into the current buffer.
2. forced linearization, if the element count for a non-linear skb
   exceeds QETH_MAX_BUFFER_ELEMENTS.

Rather than modifying qeth_get_elements_for_range() and adding overhead
to every caller, fix up those callers that are in risk of passing a
0-length range.

Fixes: 2863c61334aa ("qeth: refactor calculation of SBALE count")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   10 ++++++----
 drivers/s390/net/qeth_l3_main.c   |   11 ++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3854,10 +3854,12 @@ EXPORT_SYMBOL_GPL(qeth_get_elements_for_
 int qeth_get_elements_no(struct qeth_card *card,
 		     struct sk_buff *skb, int extra_elems, int data_offset)
 {
-	int elements = qeth_get_elements_for_range(
-				(addr_t)skb->data + data_offset,
-				(addr_t)skb->data + skb_headlen(skb)) +
-			qeth_get_elements_for_frags(skb);
+	addr_t end = (addr_t)skb->data + skb_headlen(skb);
+	int elements = qeth_get_elements_for_frags(skb);
+	addr_t start = (addr_t)skb->data + data_offset;
+
+	if (start != end)
+		elements += qeth_get_elements_for_range(start, end);
 
 	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
 		QETH_DBF_MESSAGE(2, "Invalid size of IP packet "
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2784,11 +2784,12 @@ static void qeth_tso_fill_header(struct
 static int qeth_l3_get_elements_no_tso(struct qeth_card *card,
 			struct sk_buff *skb, int extra_elems)
 {
-	addr_t tcpdptr = (addr_t)tcp_hdr(skb) + tcp_hdrlen(skb);
-	int elements = qeth_get_elements_for_range(
-				tcpdptr,
-				(addr_t)skb->data + skb_headlen(skb)) +
-				qeth_get_elements_for_frags(skb);
+	addr_t start = (addr_t)tcp_hdr(skb) + tcp_hdrlen(skb);
+	addr_t end = (addr_t)skb->data + skb_headlen(skb);
+	int elements = qeth_get_elements_for_frags(skb);
+
+	if (start != end)
+		elements += qeth_get_elements_for_range(start, end);
 
 	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
 		QETH_DBF_MESSAGE(2,
