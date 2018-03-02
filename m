Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsr7LbZDmdmOnAU+bnjr47bAzgVCvZk9s8gQmxxFmAGmNG62oncBmM9XSnbSakIcHwzryap
ARC-Seal: i=1; a=rsa-sha256; t=1519981405; cv=none;
        d=google.com; s=arc-20160816;
        b=i9RAWCXdH/ep6VQnQz+H83Z1XrAzDS3UOMJkQAjLzV4pVXa9j2/2cU23oCPlOt0iya
         l15PtSk6MOQsdds3Yob1ziEppRXcUmsO5HBgg6GNnTs254+pR85K2MCB22oUwBkS8MVp
         Kyz8P+6LsV6mnYhDo+azgT5Ht7a8DSPAezWP6IOHE5qzG2jN1DtwAQ7i8e6KKlJaH3MM
         ApiyVEvOG6VZLfaNd/ZJad/TUj2wy7wbDeoB+L3BBTeOhirzOr156xpQDw3YJg5laFjt
         gu0vjFiGmydx6ADu55vqOsUnS1d65D70TU+57s0rb0NR/wGHb/DFuRfi0MOA7+Nq2tF6
         PhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2M6IhFglmcr2XE/IJ+SMsP261dFg27ExtQszapIRURE=;
        b=Xg/MsWoXy1MmWexehE8KZkPC0haKBA9bavhnwR50ZuiAXcZeqyoQXUWnt4NLw9W5jC
         M9+m0Rvil0SGis0lx7vn89+rPcJRqyP12dQQNQxXr/6YfCN5HGVeFFVi5MSGKEt1ewCL
         vTGwJn+8BPYls/R+1Au3Vr5no9o6NWEywYpHSDL9ui3HE3jg2Yf6YbwkgRUrOoEiGzad
         ILHEMvNW09lu1t8i1Dl77hx/R99uLdFRlMZYMq3mAurZ3VUvO4czhAdRUZL0imqU7K0g
         0p36TeMNWlu8H01gzDCEacoUsm4qPeQfbqxccMrhtwdxyitGRvv0/k0vzWOWHDQzXYPO
         q/mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 081/115] i40e/i40evf: Account for frags split over multiple descriptors in check linearize
Date: Fri,  2 Mar 2018 09:51:24 +0100
Message-Id: <20180302084507.127995055@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815687679033951?=
X-GMAIL-MSGID: =?utf-8?q?1593816022516889156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@intel.com>


[ Upstream commit 248de22e638f10bd5bfc7624a357f940f66ba137 ]

The original code for __i40e_chk_linearize didn't take into account the
fact that if a fragment is 16K in size or larger it has to be split over 2
descriptors and the smaller of those 2 descriptors will be on the trailing
edge of the transmit. As a result we can get into situations where we didn't
catch requests that could result in a Tx hang.

This patch takes care of that by subtracting the length of all but the
trailing edge of the stale fragment before we test for sum. By doing this
we can guarantee that we have all cases covered, including the case of a
fragment that spans multiple descriptors. We don't need to worry about
checking the inner portions of this since 12K is the maximum aligned DMA
size and that is larger than any MSS will ever be since the MTU limit for
jumbos is something on the order of 9K.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   26 +++++++++++++++++++++++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   26 +++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3048,10 +3048,30 @@ bool __i40e_chk_linearize(struct sk_buff
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale = &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale = &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size = skb_frag_size(stale);
+
 		sum += skb_frag_size(frag++);
 
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad = -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -3059,7 +3079,7 @@ bool __i40e_chk_linearize(struct sk_buff
 		if (!nr_frags--)
 			break;
 
-		sum -= skb_frag_size(stale++);
+		sum -= stale_size;
 	}
 
 	return false;
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2014,10 +2014,30 @@ bool __i40evf_chk_linearize(struct sk_bu
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale = &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale = &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size = skb_frag_size(stale);
+
 		sum += skb_frag_size(frag++);
 
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad = -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -2025,7 +2045,7 @@ bool __i40evf_chk_linearize(struct sk_bu
 		if (!nr_frags--)
 			break;
 
-		sum -= skb_frag_size(stale++);
+		sum -= stale_size;
 	}
 
 	return false;
