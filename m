Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94CAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FD52152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FD52152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeHBSGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:06:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbeHBSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:06:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB9A7818B10B;
        Thu,  2 Aug 2018 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7D201C71A;
        Thu,  2 Aug 2018 16:14:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180723111432.26830-1-udit.agarwal@nxp.com>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
To:     Udit Agarwal <udit.agarwal@nxp.com>
Cc:     dhowells@redhat.com, zohar@linux.vnet.ibm.com, jmorris@namei.org,
        serge@hallyn.com, denkenz@gmail.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8059.1533226481.1@warthog.procyon.org.uk>
Date:   Thu, 02 Aug 2018 17:14:41 +0100
Message-ID: <8060.1533226481@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 16:14:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 16:14:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Udit Agarwal <udit.agarwal@nxp.com> wrote:

> +==========
> +Secure Key
> +==========
> +
> +Secure key is the new type added to kernel key ring service.
> +Secure key is a symmetric type key of minimum length 32 bytes
> +and with maximum possible length to be 128 bytes. It is produced
> +in kernel using the CAAM crypto engine. Userspace can only see
> +the blob for the corresponding key. All the blobs are displayed
> +or loaded in hex ascii.

To echo Mimi, this sounds suspiciously like it should have a generic
interface, not one that's specifically tied to one piece of hardware -
particularly if it's named with generic "secure".

Can you convert this into a "symmetric" type and make the backend pluggable?

> +	keyctl add secure <name> "new <keylen>" <ring>
> +	keyctl load secure <name> "load <hex_blob>" <ring>
> +	keyctl print <key_id>

There isn't a "keyctl load" that I recall.  Did you mean "keyctl add"?

I wonder if it makes sense to actually add "create" and "load" interfaces for
asymmetric and symmetric key types to aid in key management, e.g.:

	keyctl create symmetric.caam foo_munging_key len=128 @s
	keyctl load symmetric.caam foo_munging_key id=xxx @s
	keyctl create asymmetric.tpm foo_signing_key "rsa len=4096" @s
	keyctl load asymmetric.tpm foo_signing_key id=xxx @s

Note the subtype extension added to the type.  This is something I've been
meaning to add to add_key() and request_key().  It means that we don't have to
try and divine the nature of the key from the payload, but can leave the
payload as just the data if data is needed.

This might look something like:

	key = keyctl_create(const char *type, const char *desc,
			    const char *data, key_serial_t keyring);
	key = keyctl_load(const char *type, const char *desc,
			  const char *id, key_serial_t keyring);

There would probably need to be a way to query the ID of a created key also,
so that you can then pass that ID back to the loader.

	keyctl_get_id(key_serial_t key, char *buf, size_t buf_size);

David
