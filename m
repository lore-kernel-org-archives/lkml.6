Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CCC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69929217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="ghl0EsNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfAFIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:25484 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfAFIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:23 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2019 03:10:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546762221;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9CdnDbymRW1jSlQOftp+D5+4J55KrkgnjNl7ojXt46k=;
        b=ghl0EsNM1RYbkVIPzUOmbhAPxr9V8+bEG2J5pta48w144/hEpRfBNBPEtZ+Vqiw7Re
        W1z4WprW0YSBGJRKJv35DDjDgeYTjvlBD3tXyZn+Y7jVh+IkRmnNdB21TxTjXl64PaC4
        oWX8memTiMSQCFVnk7UGGb/kyP8dMGcl3MU8jTWF/4b69coUzGGmkyNA/UkwcxDQP30F
        HPQTpAM4KTMmUQhE+v4rlTLs2jBD3/zM20FFKjKRVzQO+CTH4xYE+Aa/m4BV8QnR/D+f
        dvIf8ZF5v8JG/LjWKrh9IC5LrVoT//ODvRUQE7pkDrwBhKbKU+CaMtuP9UPhGRRYbNw0
        M+qA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbI/Scimcp"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0689R7oi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 6 Jan 2019 09:09:27 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] PM / hibernate: Generate and verify signature for snapshot image
Date:   Sun, 06 Jan 2019 09:09:27 +0100
Message-ID: <1703775.N7MsT5WVgv@tauon.chronox.de>
In-Reply-To: <20190103143227.9138-3-jlee@suse.com>
References: <20190103143227.9138-1-jlee@suse.com> <20190103143227.9138-3-jlee@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Januar 2019, 15:32:24 CET schrieb Lee, Chun-Yi:

Hi Chun,

> +int snapshot_image_verify_decrypt(void)
> +{
> +	int ret, i;
> +
> +	if (!h_buf) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = snapshot_key_init();
> +	if (ret)
> +		goto error_prep;
> +
> +	ret = snapshot_prepare_hash(true);
> +	if (ret || !s4_verify_desc)
> +		goto error_prep;
> +
> +	for (i = 0; i < nr_copy_pages; i++) {
> +		ret = crypto_shash_update(s4_verify_desc, *(h_buf + i), PAGE_SIZE);
> +		if (ret)
> +			goto error_shash;
> +	}
> +
> +	ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
> +	if (ret)
> +		goto error_shash;
> +
> +	pr_debug("Signature %*phN\n", SNAPSHOT_DIGEST_SIZE, signature);
> +	pr_debug("Digest    %*phN\n", SNAPSHOT_DIGEST_SIZE, s4_verify_digest);
> +	if (memcmp(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE))
> +		ret = -EKEYREJECTED;
> +
> + error_shash:
> +	snapshot_finish_hash();
> +
> + error_prep:
> +	vfree(h_buf);
> +	if (ret)
> +		pr_warn("Signature verification failed: %d\n", ret);
> + error:
> +	sig_verify_ret = ret;
> +	return ret;
> +}

May I ask why the authentication part is done manually here? Why not using an 
AEAD cipher like the authenc() ciphers, or CCM (I would not recommend GCM 
though)? In this case, the encryption/decryption operation would automatically 
perform the creation of the hash and the verification of the hash. I.e. 
decryption can return EBADMSG which indicates an authentication failure.

> +
> +static int
> +__copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap
> *orig_bm) +{
> +	unsigned long pfn, dst_pfn;
> +	struct page *d_page;
> +	void *crypto_buffer = NULL;
> +	int ret = 0;
> +
> +	memory_bm_position_reset(orig_bm);
> +	memory_bm_position_reset(copy_bm);
> +	for (;;) {
> +		pfn = memory_bm_next_pfn(orig_bm);
> +		if (unlikely(pfn == BM_END_OF_MAP))
> +			break;
> +		dst_pfn = memory_bm_next_pfn(copy_bm);
> +		copy_data_page(dst_pfn, pfn);
> +
> +		/* Setup buffer */
> +		d_page = pfn_to_page(dst_pfn);
> +		if (PageHighMem(d_page)) {
> +			void *kaddr = kmap_atomic(d_page);
> +
> +			copy_page(buffer, kaddr);
> +			kunmap_atomic(kaddr);
> +			crypto_buffer = buffer;
> +		} else {
> +			crypto_buffer = page_address(d_page);
> +		}
> +
> +		/* Generate digest */
> +		if (!s4_verify_desc)
> +			continue;
> +		ret = crypto_shash_update(s4_verify_desc, crypto_buffer,
> +					  PAGE_SIZE);

Same here, the creation of the hash would be implicit during the encryption.

Ciao
Stephan


