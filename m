Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49b38d8yYRnjrv5atZMXfF7+z8Nac52V/D2K4V9yX05qQkbgNWcWlUQuBOZ4P6KpXaseRzv
ARC-Seal: i=1; a=rsa-sha256; t=1523473278; cv=none;
        d=google.com; s=arc-20160816;
        b=b7PhzBttsk7AVgkiJk+ih2HpQO9FkmEzNX1O/MfJNivHB88reDK2DpX168Q8q7IsYF
         1yUTVJM5Al+bRo0mYQuQz/Ld/CVIL6qSuAudjl/RRAMzFCTc7jdoXi2u7Ab2BJp/pUhk
         c6fdC4l5OE7AMb7rZas3eDE9KO2co4tc8H8l3vxAgklNJQ+IqQDYR425ZjZZl7V7Q98Z
         2snq2Xl1z4iR7NfkbYXtkBlfgewWN2iqUd4leWfnk30Y58avlYi6QKZn+h5aBLWZ/mK6
         EjlNmP+E1M3/tbxUv8NCHRyFnbICf4KjKrtA8ud3593dtjYYBkrKmEYuLtU2Q+P2eTu7
         MugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yo1TKBr215CWtfvSdfAw0O+ydtYtNPJlqWWdboDjJs8=;
        b=G+rxBkhA4MSv0Z6ExjaA1FJo9b0Z04h7xbFapmuhsaegvT1q19epUSKgKeIURz0FsH
         EmK+a2R6NwVCO6Qwu3LeAs8bJsoSUqozXL2E+AmQTzN7RtoAG7Ntvd/VZ1cxZwI5Q467
         9FDleJfh63mXWjwzwLIuM2QHVCA9gtGKEBRhpoMcHXBdI9ZGqL4JsocUb1tT9rX+G9Uf
         ycmb3d4LO/Kb/0rhYJvoLH2x76gO32pRHciMpeZB5KqWt4z9i/tIrcVdnrv9w2Xf5p+7
         oS4anm7KkwJzUcU5hwKvGug6/sDqqvQvoPqE8AbB1RQuslSl+5FvqXxIhb7uUhD5TrNE
         Q15Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Howells <dhowells@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 190/310] skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow
Date: Wed, 11 Apr 2018 20:35:29 +0200
Message-Id: <20180411183630.777163220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476225224312478?=
X-GMAIL-MSGID: =?utf-8?q?1597477515970995238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jason A. Donenfeld" <Jason@zx2c4.com>


[ Upstream commit 48a1df65334b74bd7531f932cca5928932abf769 ]

This is a defense-in-depth measure in response to bugs like
4d6fa57b4dab ("macsec: avoid heap overflow in skb_to_sgvec"). There's
not only a potential overflow of sglist items, but also a stack overflow
potential, so we fix this by limiting the amount of recursion this function
is allowed to do. Not actually providing a bounded base case is a future
disaster that we can easily avoid here.

As a small matter of house keeping, we take this opportunity to move the
documentation comment over the actual function the documentation is for.

While this could be implemented by using an explicit stack of skbuffs,
when implementing this, the function complexity increased considerably,
and I don't think such complexity and bloat is actually worth it. So,
instead I built this and tested it on x86, x86_64, ARM, ARM64, and MIPS,
and measured the stack usage there. I also reverted the recent MIPS
changes that give it a separate IRQ stack, so that I could experience
some worst-case situations. I found that limiting it to 24 layers deep
yielded a good stack usage with room for safety, as well as being much
deeper than any driver actually ever creates.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    8 +++---
 net/core/skbuff.c      |   65 +++++++++++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 27 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -984,10 +984,10 @@ struct sk_buff *skb_realloc_headroom(str
 				     unsigned int headroom);
 struct sk_buff *skb_copy_expand(const struct sk_buff *skb, int newheadroom,
 				int newtailroom, gfp_t priority);
-int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
-			int offset, int len);
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset,
-		 int len);
+int __must_check skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
+				     int offset, int len);
+int __must_check skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg,
+			      int offset, int len);
 int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer);
 int skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	consume_skb(a)
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3475,24 +3475,18 @@ void __init skb_init(void)
 						NULL);
 }
 
-/**
- *	skb_to_sgvec - Fill a scatter-gather list from a socket buffer
- *	@skb: Socket buffer containing the buffers to be mapped
- *	@sg: The scatter-gather list to map into
- *	@offset: The offset into the buffer's contents to start mapping
- *	@len: Length of buffer space to be mapped
- *
- *	Fill the specified scatter-gather list with mappings/pointers into a
- *	region of the buffer space attached to a socket buffer.
- */
 static int
-__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
+__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
+	       unsigned int recursion_level)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
 	int elt = 0;
 
+	if (unlikely(recursion_level >= 24))
+		return -EMSGSIZE;
+
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
@@ -3511,6 +3505,8 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 		end = start + skb_frag_size(&skb_shinfo(skb)->frags[i]);
 		if ((copy = end - offset) > 0) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
 
 			if (copy > len)
 				copy = len;
@@ -3525,16 +3521,22 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 	}
 
 	skb_walk_frags(skb, frag_iter) {
-		int end;
+		int end, ret;
 
 		WARN_ON(start > offset + len);
 
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
+
 			if (copy > len)
 				copy = len;
-			elt += __skb_to_sgvec(frag_iter, sg+elt, offset - start,
-					      copy);
+			ret = __skb_to_sgvec(frag_iter, sg+elt, offset - start,
+					      copy, recursion_level + 1);
+			if (unlikely(ret < 0))
+				return ret;
+			elt += ret;
 			if ((len -= copy) == 0)
 				return elt;
 			offset += copy;
@@ -3545,6 +3547,31 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 	return elt;
 }
 
+/**
+ *	skb_to_sgvec - Fill a scatter-gather list from a socket buffer
+ *	@skb: Socket buffer containing the buffers to be mapped
+ *	@sg: The scatter-gather list to map into
+ *	@offset: The offset into the buffer's contents to start mapping
+ *	@len: Length of buffer space to be mapped
+ *
+ *	Fill the specified scatter-gather list with mappings/pointers into a
+ *	region of the buffer space attached to a socket buffer. Returns either
+ *	the number of scatterlist items used, or -EMSGSIZE if the contents
+ *	could not fit.
+ */
+int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
+{
+	int nsg = __skb_to_sgvec(skb, sg, offset, len, 0);
+
+	if (nsg <= 0)
+		return nsg;
+
+	sg_mark_end(&sg[nsg - 1]);
+
+	return nsg;
+}
+EXPORT_SYMBOL_GPL(skb_to_sgvec);
+
 /* As compared with skb_to_sgvec, skb_to_sgvec_nomark only map skb to given
  * sglist without mark the sg which contain last skb data as the end.
  * So the caller can mannipulate sg list as will when padding new data after
@@ -3567,19 +3594,11 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
 			int offset, int len)
 {
-	return __skb_to_sgvec(skb, sg, offset, len);
+	return __skb_to_sgvec(skb, sg, offset, len, 0);
 }
 EXPORT_SYMBOL_GPL(skb_to_sgvec_nomark);
 
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
-{
-	int nsg = __skb_to_sgvec(skb, sg, offset, len);
 
-	sg_mark_end(&sg[nsg - 1]);
-
-	return nsg;
-}
-EXPORT_SYMBOL_GPL(skb_to_sgvec);
 
 /**
  *	skb_cow_data - Check that a socket buffer's data buffers are writable
