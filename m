Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DfgYnm1stR3KnJcZd+wZiW6pcL8WEWjNAsas5BddmMQgUCQnaMq4S0oL5jssqHYhFH++P
ARC-Seal: i=1; a=rsa-sha256; t=1523399270; cv=none;
        d=google.com; s=arc-20160816;
        b=v8bZMiGsKJcLNNOdwaHP3YI8GttNwrcgep6DtkVDu9OXE7ailmypQPXEIahndpSieE
         tH13MIZm9LeYXpzBQ0rumw3ig/2BXfQVgif8eNH+UnJxwvPVkZVkUy1YXODsx4dsl0tl
         pRKnqpIey+qv3EXLcKC9iQobIKNa4PgAE5fqa+cMR0chYHKxNc7XfGrnp3avhaMV7U33
         i9QLKHEGyWCGacVA98xVk79H85bWyrVh0NHZ9Cgg152J+TS68DsDNGcFc3F5RZhR7rqI
         zHxClKvqwtudwh9ORqRdhajiLwgZpxIWFlSAVxE6XMZAsnCkJjKCQEO4JpDRx5eRUQJr
         w2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c8WImE7MMXQ/Vt6e1/6aZC4TUgOyn1cpDHY5rQwIEUQ=;
        b=AAUch7AsHJrXued5cbpVWmkHxYS8aj5RgwaBHOt6iA2CoeRZFtGsHX7DXDlAzM6Yws
         8gBVmi6sSxDCDEGsXthfiRZg+CfMwxJqx4uIktddcHyqymcpCKVfzO1dxpAJdrGa3/0F
         Jo9dsFOEwnb7dySYDXij4cDe6FfS/fkV2BtcW89m91ZRgAN0RoamtwHx7nPnfJxKfOtD
         ueAHXPUXlGHMMB6d3XJiDNZusrd9P79F/FVS2AJWQJC237X+C/X2nAhG8ApH0TbnhOlm
         1xoMvscqZMrswT9VPpJrHYD0/mGBZ0mVdWGs/Gp81hBbXDrl5ilBUvK2C65lJxCZR6Bu
         J/0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 047/168] crypto: crypto4xx - perform aead icv check in the driver
Date: Wed, 11 Apr 2018 00:23:09 +0200
Message-Id: <20180410212802.210479322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399913170962065?=
X-GMAIL-MSGID: =?utf-8?q?1597399913170962065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>


[ Upstream commit 0b5a7f71b4c557b15ec54a1b49023bc1b21044cc ]

The ccm-aes-ppc4xx now fails one of testmgr's expected
failure test cases as such:

|decryption failed on test 10 for ccm-aes-ppc4xx:
|ret was 0, |expected -EBADMSG

It doesn't look like the hardware sets the authentication failure
flag. The original vendor source from which this was ported does
not have any special code or notes about why this would happen or
if there are any WAs.

Hence, this patch converts the aead_done callback handler to
perform the icv check in the driver. And this fixes the false
negative and the ccm-aes-ppc4xx passes the selftests once again.

|name         : ccm(aes)
|driver       : ccm-aes-ppc4xx
|module       : crypto4xx
|priority     : 300
|refcnt       : 1
|selftest     : passed
|internal     : no
|type         : aead
|async        : yes
|blocksize    : 1
|ivsize       : 16
|maxauthsize  : 16
|geniv        : <none>

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/amcc/crypto4xx_alg.c  |    6 ---
 drivers/crypto/amcc/crypto4xx_core.c |   54 +++++++++++++++++------------------
 2 files changed, 28 insertions(+), 32 deletions(-)

--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -256,10 +256,6 @@ static inline bool crypto4xx_aead_need_f
 	if (is_ccm && !(req->iv[0] == 1 || req->iv[0] == 3))
 		return true;
 
-	/* CCM - fix CBC MAC mismatch in special case */
-	if (is_ccm && decrypt && !req->assoclen)
-		return true;
-
 	return false;
 }
 
@@ -330,7 +326,7 @@ int crypto4xx_setkey_aes_ccm(struct cryp
 	sa = (struct dynamic_sa_ctl *) ctx->sa_in;
 	sa->sa_contents.w = SA_AES_CCM_CONTENTS | (keylen << 2);
 
-	set_dynamic_sa_command_0(sa, SA_NOT_SAVE_HASH, SA_NOT_SAVE_IV,
+	set_dynamic_sa_command_0(sa, SA_SAVE_HASH, SA_NOT_SAVE_IV,
 				 SA_LOAD_HASH_FROM_SA, SA_LOAD_IV_FROM_STATE,
 				 SA_NO_HEADER_PROC, SA_HASH_ALG_CBC_MAC,
 				 SA_CIPHER_ALG_AES,
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -570,15 +570,14 @@ static void crypto4xx_aead_done(struct c
 				struct pd_uinfo *pd_uinfo,
 				struct ce_pd *pd)
 {
-	struct aead_request *aead_req;
-	struct crypto4xx_ctx *ctx;
+	struct aead_request *aead_req = container_of(pd_uinfo->async_req,
+		struct aead_request, base);
 	struct scatterlist *dst = pd_uinfo->dest_va;
+	size_t cp_len = crypto_aead_authsize(
+		crypto_aead_reqtfm(aead_req));
+	u32 icv[cp_len];
 	int err = 0;
 
-	aead_req = container_of(pd_uinfo->async_req, struct aead_request,
-				base);
-	ctx  = crypto_tfm_ctx(aead_req->base.tfm);
-
 	if (pd_uinfo->using_sd) {
 		crypto4xx_copy_pkt_to_dst(dev, pd, pd_uinfo,
 					  pd->pd_ctl_len.bf.pkt_len,
@@ -590,38 +589,39 @@ static void crypto4xx_aead_done(struct c
 
 	if (pd_uinfo->sa_va->sa_command_0.bf.dir == DIR_OUTBOUND) {
 		/* append icv at the end */
-		size_t cp_len = crypto_aead_authsize(
-			crypto_aead_reqtfm(aead_req));
-		u32 icv[cp_len];
-
 		crypto4xx_memcpy_from_le32(icv, pd_uinfo->sr_va->save_digest,
 					   cp_len);
 
 		scatterwalk_map_and_copy(icv, dst, aead_req->cryptlen,
 					 cp_len, 1);
+	} else {
+		/* check icv at the end */
+		scatterwalk_map_and_copy(icv, aead_req->src,
+			aead_req->assoclen + aead_req->cryptlen -
+			cp_len, cp_len, 0);
+
+		crypto4xx_memcpy_from_le32(icv, icv, cp_len);
+
+		if (crypto_memneq(icv, pd_uinfo->sr_va->save_digest, cp_len))
+			err = -EBADMSG;
 	}
 
 	crypto4xx_ret_sg_desc(dev, pd_uinfo);
 
 	if (pd->pd_ctl.bf.status & 0xff) {
-		if (pd->pd_ctl.bf.status & 0x1) {
-			/* authentication error */
-			err = -EBADMSG;
-		} else {
-			if (!__ratelimit(&dev->aead_ratelimit)) {
-				if (pd->pd_ctl.bf.status & 2)
-					pr_err("pad fail error\n");
-				if (pd->pd_ctl.bf.status & 4)
-					pr_err("seqnum fail\n");
-				if (pd->pd_ctl.bf.status & 8)
-					pr_err("error _notify\n");
-				pr_err("aead return err status = 0x%02x\n",
-					pd->pd_ctl.bf.status & 0xff);
-				pr_err("pd pad_ctl = 0x%08x\n",
-					pd->pd_ctl.bf.pd_pad_ctl);
-			}
-			err = -EINVAL;
+		if (!__ratelimit(&dev->aead_ratelimit)) {
+			if (pd->pd_ctl.bf.status & 2)
+				pr_err("pad fail error\n");
+			if (pd->pd_ctl.bf.status & 4)
+				pr_err("seqnum fail\n");
+			if (pd->pd_ctl.bf.status & 8)
+				pr_err("error _notify\n");
+			pr_err("aead return err status = 0x%02x\n",
+				pd->pd_ctl.bf.status & 0xff);
+			pr_err("pd pad_ctl = 0x%08x\n",
+				pd->pd_ctl.bf.pd_pad_ctl);
 		}
+		err = -EINVAL;
 	}
 
 	if (pd_uinfo->state & PD_ENTRY_BUSY)
