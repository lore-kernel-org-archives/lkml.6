Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrjUpU7hjAN5KGS9EpDnpx/NZNZWlnh8QmVdxZmJr1bTQD+tlhvB/1qmEPYo3s/q5tSpwCO
ARC-Seal: i=1; a=rsa-sha256; t=1524838349; cv=none;
        d=google.com; s=arc-20160816;
        b=F77wQspYaQmEI7hsxmnYD0W2+Ha3VIGFztBXbbKYaPRUB8TubRKLXlqq8T/oiDxjx6
         w5Wyzh+sy8L4DOENtaJ6m/zUx6O3DAneSdN/zVX6NHDtw7iNHpTskiXbSAKFeazJm9lh
         wY55zSBLdUDIdp8miJtHRt54qnl8a4+ead052G4d0Fsco/yLbUqmBZ1l5ExEA6Qr8byb
         YJj0GG9jmvezo1j3eK6fSOXr13nHvyq/52EuuUqaQtJBZJmUsUN3F9kCvRv+Vc9soMuV
         F0SpwuCaoDaM7tFHotiOx1sd/XV81Br/F2ZEpMehrhMYsIoGzRhiQtheKlBZ3llymYWM
         mnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=17mZ6jlgc4NvWJwU7gLZxTU5RHJcSSOKT5DyXqEyd4E=;
        b=IXrU1F+97TYXHuAfl97FoIhKBC3gCz2CJHjHYgzAg/1EbDjV8wp4hRkKt5Z+CQbVk3
         5tmzFzwkpX+ntTHxc3xO/AG/HeGUJEU35vpldusfqmEEg8oNC4IpLDfch40BL5thn0G5
         UaXL5ACsv+peP90/ShAWzN9vfrhvAzAkk3Jdg86ySaJ4lLSVzdcH8IRkBtYGkCSMlgY1
         WK7863iYcGw3wHq4AbDqZvzjWAu5Zv9r2dZn30eIe/4fMlpXAjFZJu6YXMhLCQsgFvPw
         0g5JpJaPcyKQDv81E/B/etXeoKWdxmD5r8wMmLvNHByrR8QnD5UhCXO8v75jxDOqXUeI
         rxyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33B821895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Aring <aring@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 39/81] net: sched: ife: handle malformed tlv length
Date: Fri, 27 Apr 2018 15:58:41 +0200
Message-Id: <20180427135745.362555965@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908683472682210?=
X-GMAIL-MSGID: =?utf-8?q?1598908897189579247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit cc74eddd0ff325d57373cea99f642b787d7f76f5 ]

There is currently no handling to check on a invalid tlv length. This
patch adds such handling to avoid killing the kernel with a malformed
ife packet.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ife.h   |    3 ++-
 net/ife/ife.c       |   35 +++++++++++++++++++++++++++++++++--
 net/sched/act_ife.c |    7 ++++++-
 3 files changed, 41 insertions(+), 4 deletions(-)

--- a/include/net/ife.h
+++ b/include/net/ife.h
@@ -12,7 +12,8 @@
 void *ife_encode(struct sk_buff *skb, u16 metalen);
 void *ife_decode(struct sk_buff *skb, u16 *metalen);
 
-void *ife_tlv_meta_decode(void *skbdata, u16 *attrtype, u16 *dlen, u16 *totlen);
+void *ife_tlv_meta_decode(void *skbdata, const void *ifehdr_end, u16 *attrtype,
+			  u16 *dlen, u16 *totlen);
 int ife_tlv_meta_encode(void *skbdata, u16 attrtype, u16 dlen,
 			const void *dval);
 
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -92,12 +92,43 @@ struct meta_tlvhdr {
 	__be16 len;
 };
 
+static bool __ife_tlv_meta_valid(const unsigned char *skbdata,
+				 const unsigned char *ifehdr_end)
+{
+	const struct meta_tlvhdr *tlv;
+	u16 tlvlen;
+
+	if (unlikely(skbdata + sizeof(*tlv) > ifehdr_end))
+		return false;
+
+	tlv = (const struct meta_tlvhdr *)skbdata;
+	tlvlen = ntohs(tlv->len);
+
+	/* tlv length field is inc header, check on minimum */
+	if (tlvlen < NLA_HDRLEN)
+		return false;
+
+	/* overflow by NLA_ALIGN check */
+	if (NLA_ALIGN(tlvlen) < tlvlen)
+		return false;
+
+	if (unlikely(skbdata + NLA_ALIGN(tlvlen) > ifehdr_end))
+		return false;
+
+	return true;
+}
+
 /* Caller takes care of presenting data in network order
  */
-void *ife_tlv_meta_decode(void *skbdata, u16 *attrtype, u16 *dlen, u16 *totlen)
+void *ife_tlv_meta_decode(void *skbdata, const void *ifehdr_end, u16 *attrtype,
+			  u16 *dlen, u16 *totlen)
 {
-	struct meta_tlvhdr *tlv = (struct meta_tlvhdr *) skbdata;
+	struct meta_tlvhdr *tlv;
+
+	if (!__ife_tlv_meta_valid(skbdata, ifehdr_end))
+		return NULL;
 
+	tlv = (struct meta_tlvhdr *)skbdata;
 	*dlen = ntohs(tlv->len) - NLA_HDRLEN;
 	*attrtype = ntohs(tlv->type);
 
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -682,7 +682,12 @@ static int tcf_ife_decode(struct sk_buff
 		u16 mtype;
 		u16 dlen;
 
-		curr_data = ife_tlv_meta_decode(tlv_data, &mtype, &dlen, NULL);
+		curr_data = ife_tlv_meta_decode(tlv_data, ifehdr_end, &mtype,
+						&dlen, NULL);
+		if (!curr_data) {
+			qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+			return TC_ACT_SHOT;
+		}
 
 		if (find_decode_metaid(skb, ife, mtype, dlen, curr_data)) {
 			/* abuse overlimits to count when we receive metadata
