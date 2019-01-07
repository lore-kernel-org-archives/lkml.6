Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE3E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfAGIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:07:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:58410 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAGIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:07:15 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 99BBC72CC71;
        Mon,  7 Jan 2019 11:07:11 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7DE394A4A14;
        Mon,  7 Jan 2019 11:07:11 +0300 (MSK)
Date:   Mon, 7 Jan 2019 11:07:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] crypto: Add EC-RDSA algorithm
Message-ID: <20190107080710.r4bh7gkqdysxmlnn@sole.flsd.net>
Mail-Followup-To: Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-5-vt@altlinux.org>
 <1893001.R2IGJoHzOM@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1893001.R2IGJoHzOM@positron.chronox.de>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

On Sun, Jan 06, 2019 at 07:11:50PM +0100, Stephan Müller wrote:
> Am Sonntag, 6. Januar 2019, 14:36:08 CET schrieb Vitaly Chikunov:
> 
> > Add Elliptic Curve Russian Digital Signature Algorithm (GOST R
> > 34.10-2012, RFC 7091, ISO/IEC 14888-3) is one of the Russian (and since
> > 2018 the CIS countries) cryptographic standard algorithms (called GOST
> > algorithms). Only signature verification is supported, with intent to be
> > used in the IMA.
> 
> Do you happen to have test vectors for the testmgr?

Yes, I will add this.

> > +/* Parse DER encoded subjectPublicKey. */
> > +static int ecrdsa_set_pub_key(struct crypto_akcipher *tfm, const void *ber,
> > +			      unsigned int len)
> > +{
> > +	struct ecrdsa_ctx *ctx = akcipher_tfm_ctx(tfm);
> > +	unsigned int ndigits;
> > +	const u8 *k = ber;
> > +	unsigned int offset;
> > +
> > +	/* First chance to zero ctx */
> > +	memset(ctx, 0, sizeof(*ctx));
> > +
> > +	if (len < 3 ||
> > +	    k[0] != 0x04 || /* OCTET STRING */
> > +	    (k[1] < 0x80 && len != k[1] + 2) ||
> > +	    (k[1] == 0x81 && len != k[2] + 3) ||
> > +	    k[1] > 0x81)
> > +		return -EBADMSG;
> > +	offset = (k[1] < 0x80)? 2 : 3;
> > +	k += offset;
> > +	len -= offset;
> 
> Why do you manually parse the ASN.1 structure instead of using the ASN.1 
> parser?

I am not sure this worth effort and will not be most degenerate use of
asn1_ber_decoder, since 1) I only need to parse one type in each case:
OCTET STRING string above code, and OIDs in below code; 2) this data is
said to be in DER format, which asn1_ber_decoder can not enforce. Surely
this will also produce more code and files.

> > +/* Parse DER encoded SubjectPublicKeyInfo.AlgorithmIdentifier.parameters.
> > */ +static int ecrdsa_set_params(struct crypto_akcipher *tfm, enum OID
> > algo, +			     const void *params, unsigned int paramlen)
> > +{
> > +	struct ecrdsa_ctx *ctx = akcipher_tfm_ctx(tfm);
> > +	const u8 *p = params;
> > +	int i;
> > +
> > +	if (algo == OID_gost2012PublicKey256) {
> > +		ctx->digest	= "streebog256";
> > +		ctx->digest_oid	= OID_gost2012Digest256;
> > +		ctx->digest_len	= 256 / 8;
> > +	} else if (algo == OID_gost2012PublicKey512) {
> > +		ctx->digest	= "streebog512";
> > +		ctx->digest_oid	= OID_gost2012Digest512;
> > +		ctx->digest_len	= 512 / 8;
> > +	} else
> > +		return -ENOPKG;
> > +	ctx->curve = NULL;
> > +	ctx->curve_oid = 0;
> > +	ctx->algo_oid = algo;
> > +
> > +	for (i = 0; i < paramlen; i += p[i + 1] + 2) {
> > +		const struct ecc_curve *curve;
> > +		enum OID oid;
> > +
> > +		if (paramlen - i < 2 ||
> > +		    p[i] != 0x06 || /* OBJECT IDENTIFIER */
> 
> Same here and in the following
> 
> > +		    p[i + 1] > paramlen - i - 2)
> > +			return -EBADMSG;
> > +		oid = look_up_OID(p + i + 2, p[i + 1]);

> > +MODULE_ALIAS_CRYPTO("ecrdsa");
> 
> I do not think you need that alias as the module name already will be named 
> this way. I guess you rather should add ecrdsa-generic as module alias.

Thanks!

