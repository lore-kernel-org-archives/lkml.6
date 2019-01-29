Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB832183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548755601;
	bh=Dv5WAWwxOjJCOSKBm3bcnreU0q5AdFFEetxZtFvCwIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G01QMnNzIGIhL9HQJxVDofayT4GWyiK/K+AnNQAW0CqkdM1/idoJ/BIAtvWFjv9Yj
	 sRS7VseJ01ZDK2w5jfikBmsylyzGa6JfSXAiJheAQiGKvN8rh69hHI+8CPRHwxe2ZS
	 5F2fk0mcVBH9Nxzy2jfcPFNfWfkaq2lI4RKAYk7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfA2JxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2JxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:53:18 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36DA2183F;
        Tue, 29 Jan 2019 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548755598;
        bh=Dv5WAWwxOjJCOSKBm3bcnreU0q5AdFFEetxZtFvCwIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNlh4KOPRq2ZBJL3NKoxQ0U5wDXEmYiiKIqqU7rAjeOyMivEcLwdQO+L2QGUrhQmw
         CxI+KYnHDMT9uA++yWaV4AU55nY5s5SDr0uzn9PwepQzEg8WhTlUANxOJvGoe3Ogq1
         iDtg+GvbK/xYczsf1UqZkDhu6GVYKwzMy1q7CbY4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDD7A4034F; Tue, 29 Jan 2019 10:53:15 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:53:15 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, dzickus@redhat.com, fowles@inreach.com,
        jmario@redhat.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
Message-ID: <20190129095315.GH4344@kernel.org>
References: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
 <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
 <874l9rsson.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l9rsson.fsf@concordia.ellerman.id.au>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 29, 2019 at 08:45:44PM +1100, Michael Ellerman escreveu:
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> 
> > On 1/14/19 9:44 AM, Ravi Bangoria wrote:
> >> Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
> >> event and, perf_mem_events by default includes ldlat=30 which is
> >> causing failure on powerpc. Refactor code to support perf mem/c2c on
> >> powerpc.
> >> 
> >> This patch depends on kernel side changes done my Madhavan:
> >> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
> >> 
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >
> >
> > Arnaldo / Michael, Any thoughts?
> 
> I haven't merged the kernel patch, I think because Maddy told me not to
> because it would break the userspace tooling :)
> 
> What is the actual dependency between them? ie. should we merge the
> kernel fix first or second or what?

I think its just a tooling side, I haven't processed it because I'm
waiting for Ravi to address Jiri's comment, after that I'm happy to put
it in my perf/urgent branch that I'm brewing to push to Ingo today or
tomorrow.

- Arnaldo
