Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225k3XXX2hHEtjxxGCIDPkIYiNIkjukHUOx0AiFh34vJfn1iyLIMddPkcgO6jH9JUYE9u/C9
ARC-Seal: i=1; a=rsa-sha256; t=1519218685; cv=none;
        d=google.com; s=arc-20160816;
        b=PohWx4KcuDM7zaUUunHyI+vWca3kmmD/m4uVYtspVLpdBepZudgwn4pqkrM5/9JIRq
         mWiFC9M63MzkCX31v3le/w3vF0Z0xj42h3aDXoPDPwXozx+Ji42K1EjBp82/WtNN4zvO
         1FM99TJEO1zD5AV/DBPD8Rk3A/mBHLyzEdMHmitVGcRmg7maaGLnK9zJFP+2GG+C/rSs
         lMJWE1phYw8sTLM3woUgiLuQ3Y6AFru4rCWQwMfpTJ+4P8wD++HAlN0RegysKaffw7v0
         cpV5BhMmtuAsgIFAVGhNb0dOkAJFeXhviXdo2C0NKCNAxQib13eZTnGdGfU67ONMAgYM
         Hbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dYHdFifZ26HcY22pIHUurlVzYmC+VOGUF06UJg3+lRk=;
        b=gBaoQzD3b3S+WnAbnxNPkBEC8guIVH1xmPrHBOamsZGGrrHgchU0sDIrjB68HJ3gZ2
         hry/nronOwPaoUfilqEoA20MvWqRVLXE8PKilocVhJ9FXNhwZHql4NDuLqT+5htCgvzO
         UcaUckzjMyZ+hTDPlERJ6vN20vQc80QwV43a8g7WvySMoFY4ye+Sv13kc2LRVlyztSY2
         Im9eRdHgUVRfsDND/V6jUvvxQI9SVdPdkpP3uwQ7NVgFf6ZrEYw7KgQl2eDPYyVrPa2+
         8l4MnkR1Z5xjWvPlKlVX9E9u4IfD3k/qOXepqBTjEDb6ZI1tMb1gBjmHQeddYO2rL7sk
         v7lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.15 126/163] mpls, nospec: Sanitize array index in mpls_label_ok()
Date: Wed, 21 Feb 2018 13:49:15 +0100
Message-Id: <20180221124537.097119821@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015743562020219?=
X-GMAIL-MSGID: =?utf-8?q?1593016252797037473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 3968523f855050b8195134da951b87c20bd66130 upstream.

mpls_label_ok() validates that the 'platform_label' array index from a
userspace netlink message payload is valid. Under speculation the
mpls_label_ok() result may not resolve in the CPU pipeline until after
the index is used to access an array element. Sanitize the index to zero
to prevent userspace-controlled arbitrary out-of-bounds speculation, a
precursor for a speculative execution side channel vulnerability.

Cc: <stable@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mpls/af_mpls.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -8,6 +8,7 @@
 #include <linux/ipv6.h>
 #include <linux/mpls.h>
 #include <linux/netconf.h>
+#include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/percpu.h>
 #include <net/ip.h>
@@ -935,24 +936,27 @@ errout:
 	return err;
 }
 
-static bool mpls_label_ok(struct net *net, unsigned int index,
+static bool mpls_label_ok(struct net *net, unsigned int *index,
 			  struct netlink_ext_ack *extack)
 {
+	bool is_ok = true;
+
 	/* Reserved labels may not be set */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED) {
+	if (*index < MPLS_LABEL_FIRST_UNRESERVED) {
 		NL_SET_ERR_MSG(extack,
 			       "Invalid label - must be MPLS_LABEL_FIRST_UNRESERVED or higher");
-		return false;
+		is_ok = false;
 	}
 
 	/* The full 20 bit range may not be supported. */
-	if (index >= net->mpls.platform_labels) {
+	if (is_ok && *index >= net->mpls.platform_labels) {
 		NL_SET_ERR_MSG(extack,
 			       "Label >= configured maximum in platform_labels");
-		return false;
+		is_ok = false;
 	}
 
-	return true;
+	*index = array_index_nospec(*index, net->mpls.platform_labels);
+	return is_ok;
 }
 
 static int mpls_route_add(struct mpls_route_config *cfg,
@@ -975,7 +979,7 @@ static int mpls_route_add(struct mpls_ro
 		index = find_free_label(net);
 	}
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	/* Append makes no sense with mpls */
@@ -1052,7 +1056,7 @@ static int mpls_route_del(struct mpls_ro
 
 	index = cfg->rc_label;
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	mpls_route_update(net, index, NULL, &cfg->rc_nlinfo);
@@ -1810,7 +1814,7 @@ static int rtm_to_route_config(struct sk
 				goto errout;
 
 			if (!mpls_label_ok(cfg->rc_nlinfo.nl_net,
-					   cfg->rc_label, extack))
+					   &cfg->rc_label, extack))
 				goto errout;
 			break;
 		}
@@ -2137,7 +2141,7 @@ static int mpls_getroute(struct sk_buff
 			goto errout;
 		}
 
-		if (!mpls_label_ok(net, in_label, extack)) {
+		if (!mpls_label_ok(net, &in_label, extack)) {
 			err = -EINVAL;
 			goto errout;
 		}
