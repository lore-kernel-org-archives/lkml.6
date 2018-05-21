Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpm81JafBlEoANxGLLny7Op7S9Oqoh6MQZzgVN46kjbI2Od0MglPALoMF2f0eaazdzTZggO
ARC-Seal: i=1; a=rsa-sha256; t=1526937776; cv=none;
        d=google.com; s=arc-20160816;
        b=RNDsEWwu9kDxrGQVfUv4qnJ/URX98z7PIeyitwkg2M1x0AKGx5jxF2ZO4MVkQ9l0fW
         a6LyZY6gKr6WlyP6jkYs4Sw4l8RfMRPt+aPWw3np+Bs+l66Zrq3VCyuiEvBK8jXt62U+
         TIxEZGci5J0Gsa+z7gxkdPNTc9IHDU1aK+opkE1ofL+88Wuii5ChxRzzzKulPCEwCPbQ
         U5Yk5ydhurz5Zprdx4WQAJKGd+1FBv4v+fRCsis/9+4dsu2tqiKGtE0hyixAA31kj7Zk
         ab+uSGk42HVIUDx9WK3Zr8RsaI3+iQdwX2rMIOhcv4j7WSmlIDyKEIfmK0UKkFJBGQnn
         9FBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tUuHKByBXiaqRSPHduhlUz9RuLqk8Jo337xoXkunP/g=;
        b=poGColEDSX1pmWgBREELnlxtxMUMiERRTPJ5bkBvOw5VN+aZJimw8ejpUnJzGnH7MP
         Gxh2oEHlZQzZ3T2V/E2xNbUzfK2eSI6nuc/8oaPfjFuCKV3beTBfKOQ1DWj+tFI5xFOo
         ETKL5KkHeBh/vNYKRZTO0n+YSV47KHP5gmBPqf+HMySeyLpzWEj2yrbIqkqHozYcM0OY
         cOPHkAr8tFnKZ4fnoyHL0vEhIB8nm10fhP+AKWGiOISUetrLKai3x36hFLddMhoCn+Le
         QZ23RKGANbIhGeYfVdJCYbv/P3k1QTeAG1F7Tb6yaok32Ng278FIjuxNDnMjvBL0KnR4
         CibA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YADzj9OL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YADzj9OL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre Morel <pmorel@linux.vnet.ibm.com>,
	Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
	Halil Pasic <pasic@linux.vnet.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 021/110] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Mon, 21 May 2018 23:11:18 +0200
Message-Id: <20180521210505.740716749@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110010443793395?=
X-GMAIL-MSGID: =?utf-8?q?1601110305640402598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Halil Pasic <pasic@linux.vnet.ibm.com>

commit d66a7355717ec903d455277a550d930ba13df4a8 upstream.

If the translation of a channel program fails, we may end up attempting
to clean up (free, unpin) stuff that never got translated (and allocated,
pinned) in the first place.

By adjusting the lengths of the chains accordingly (so the element that
failed, and all subsequent elements are excluded) cleanup activities
based on false assumptions can be avoided.

Let's make sure cp_free works properly after cp_prefetch returns with an
error by setting ch_len of a ccw chain to the number of the translated
CCWs on that chain.

Cc: stable@vger.kernel.org #v4.12+
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
[CH: fixed typos]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/vfio_ccw_cp.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
  * and stores the result to ccwchain list. @cp must have been
  * initialized by a previous call with cp_init(). Otherwise, undefined
  * behavior occurs.
+ * For each chain composing the channel program:
+ * - On entry ch_len holds the count of CCWs to be translated.
+ * - On exit ch_len is adjusted to the count of successfully translated CCWs.
+ * This allows cp_free to find in ch_len the count of CCWs to free in a chain.
  *
  * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
  * as helpers to do ccw chain translation inside the kernel. Basically
@@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that were actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
