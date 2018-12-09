Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C2AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8870220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeLIV4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39028 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeLIV4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:56:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gW74F-0000z6-LH; Sun, 09 Dec 2018 21:56:51 +0000
Date:   Sun, 9 Dec 2018 21:56:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-sparse@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209215651.GD2217@ZenIV.linux.org.uk>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
 <20181209213951.kumz33u6prb2seqz@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209213951.kumz33u6prb2seqz@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 10:39:52PM +0100, Luc Van Oostenryck wrote:

> There are several more or less bad/good solutions, like:
> * add raw_copy_{to,from}_user() in the list of checked function
>   (not inlined in most archs).
> * add a new annotation to force sparse to check the byte count
>   (I'm thinking about __range__/OP_RANGE or something similar).
> * do these checks before functions are inlined (but then some
>   constant count could not yet be seen as constant).
  * just spell it out in copy_to_user() itself - as in
#ifdef C_T_U_SIZE_LIMIT
	if (__builtin_constant_p(count) && count > C_T_U_SIZE_LIMIT)
		/* something warning-triggering */
#endif
in the beginning of copy_from_user().  Or simply
#ifdef C_T_U_SIZE_LIMIT
	BUILD_BUG_ON(__builtin_constant_p(count) && count > C_T_U_SIZE_LIMIT);
#endif
in there...
