Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+s9JvpBqGtD7/HbeSYQUuyZhU1XleYPQQRAi7zHINrIYqnv1hN3aRkwwYWRcL8vev/0pg
ARC-Seal: i=1; a=rsa-sha256; t=1520451776; cv=none;
        d=google.com; s=arc-20160816;
        b=sq3RJLDhlAeyBqV4VB6paIFvC2YPiENm4PRzebTM5xnifwhFa8TwDHCyUdqFpA1MF7
         NxrEk5nHahM7J6lb/gkGgXQpcjyRuYztIj7r3pgFTix+w57pNbd+r8JVJwssVMXYNqya
         vYG9rRQWtqsxcIBzazkrz4mYhz3Re2aRPUiJq56PhbifkebFLvCKLaCJ/SF/onaetY4v
         N97zZsFyNzAr1gbUhfb+EcZ1cORzhdPomffT4w3NlCw9KurmI2DY/OZ+YZrmEEQl7Vu5
         Eni0yClOfLzh6QZxQoSChuC7FK7LfpCYDkDRbKggLVuoPrK86fPwivY5YWkPM7LFGMJN
         2KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cKaYOjXF9vvySWkOcX0mwX7RNYVzq10Ky6cpp9zOcAk=;
        b=m9WDoD7oQT2E9UxVdtWhRPGrz19nJC0eVn6YAefeCR6OhKlbQUMegDVzoPc8SVoN7g
         weO9o4MP4OH8wTCDjrdBrzgWEAeqV8+QTxNOl3tQERenn9K2hv4fsyisKN8gbWjhxUxG
         X4+ZypC7+N/hXykpTAXtyp2lHZN6+qePQmQmlxMRj+4iPvmEUa7EKEZOpgOvo4RBZmQI
         DHquSJ03wkRl9WTRROUqxCu13bUcWTJD5OoFOtpm/04RD+ZpfjEXOh7mY67PSFR3Wipi
         h/l/v2OSkTj0az9hEHmQiXFaBWg00YsBXif9uTLk4Z/bun2WhSJlrtesXGRlUovYL1Ee
         MH7Q==
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
Subject: [PATCH 4.15 090/122] s390/qeth: fix overestimated count of buffer elements
Date: Wed,  7 Mar 2018 11:38:22 -0800
Message-Id: <20180307191742.404980376@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309241524248361?=
X-GMAIL-MSGID: =?utf-8?q?1594309241524248361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3835,10 +3835,12 @@ EXPORT_SYMBOL_GPL(qeth_get_elements_for_
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
@@ -2629,11 +2629,12 @@ static void qeth_tso_fill_header(struct
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
