Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B358255A6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXIp/yz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B358255A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeGBGeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753465AbeGBGeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:34:07 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CD92555B;
        Mon,  2 Jul 2018 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530513246;
        bh=03yaajkqqPNEwoTqSo0J4bDGMbOnunsE0UIdlpcvIjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXIp/yz8EG2rsQZJG3DIE2ho3bBlirnBDNsPsaWxWE17bfEWvLLjiqD32W4+L/rkI
         wEe851gpt9dQYys1irgxDwXXq9egsikO8GqIIgeduepb3dX9QSUz94wkuP8sl/E65K
         acRhE4IJCo1zROVe2S0Rk40Mt4IgCyrdfARxL4w4=
Date:   Mon, 2 Jul 2018 09:34:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180702063403.GX3014@mtr-leonro.mtl.com>
References: <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
 <20180627145718.GB20171@ziepe.ca>
 <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
 <1f6e79c5-5801-16d2-18a6-66bd0712b5b8@nvidia.com>
 <20180628091743.khhta7nafuwstd3m@quack2.suse.cz>
 <20180702055251.GV3014@mtr-leonro.mtl.com>
 <235a23e3-6e02-234c-3e20-b2dddc93e568@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <235a23e3-6e02-234c-3e20-b2dddc93e568@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 01, 2018 at 11:10:04PM -0700, John Hubbard wrote:
> On 07/01/2018 10:52 PM, Leon Romanovsky wrote:
> > On Thu, Jun 28, 2018 at 11:17:43AM +0200, Jan Kara wrote:
> >> On Wed 27-06-18 19:42:01, John Hubbard wrote:
> >>> On 06/27/2018 10:02 AM, Jan Kara wrote:
> >>>> On Wed 27-06-18 08:57:18, Jason Gunthorpe wrote:
> >>>>> On Wed, Jun 27, 2018 at 02:42:55PM +0200, Jan Kara wrote:
> >>>>>> On Wed 27-06-18 13:59:27, Michal Hocko wrote:
> >>>>>>> On Wed 27-06-18 13:53:49, Jan Kara wrote:
> >>>>>>>> On Wed 27-06-18 13:32:21, Michal Hocko wrote:
> >>>>>>> [...]
> >>> One question though: I'm still vague on the best actions to take in the
> >>> following functions:
> >>>
> >>>     page_mkclean_one
> >>>     try_to_unmap_one
> >>>
> >>> At the moment, they are both just doing an evil little early-out:
> >>>
> >>> 	if (PageDmaPinned(page))
> >>> 		return false;
> >>>
> >>> ...but we talked about maybe waiting for the condition to clear, instead?
> >>> Thoughts?
> >>
> >> What needs to happen in page_mkclean() depends on the caller. Most of the
> >> callers really need to be sure the page is write-protected once
> >> page_mkclean() returns. Those are:
> >>
> >>   pagecache_isize_extended()
> >>   fb_deferred_io_work()
> >>   clear_page_dirty_for_io() if called for data-integrity writeback - which
> >>     is currently known only in its caller (e.g. write_cache_pages()) where
> >>     it can be determined as wbc->sync_mode == WB_SYNC_ALL. Getting this
> >>     information into page_mkclean() will require some plumbing and
> >>     clear_page_dirty_for_io() has some 50 callers but it's doable.
> >>
> >> clear_page_dirty_for_io() for cleaning writeback (wbc->sync_mode !=
> >> WB_SYNC_ALL) can just skip pinned pages and we probably need to do that as
> >> otherwise memory cleaning would get stuck on pinned pages until RDMA
> >> drivers release its pins.
> >
> > Sorry for naive question, but won't it create too much dirty pages
> > so writeback will be called "non-stop" to rebalance watermarks without
> > ability to progress?
> >
>
> That is an interesting point.
>
> Holding off page writeback of this region does seem like it could cause
> problems under memory pressure. Maybe adjusting the watermarks so that we
> tell the writeback  system, "all is well, just ignore this region until
> we're done with it" might help? Any ideas here are welcome...

AFAIR, it is per-zone, so the solution to count dirty-but-untouchable
number of pages to take them into account for accounting can work, but
it seems like an overkill. Can we create special ZONE for such gup
pages, or this is impossible too?

>
> Longer term, maybe some additional work could allow the kernel to be able
> to writeback the gup-pinned pages (while DMA is happening--snapshots), but
> that seems like a pretty big overhaul.
>
> thanks,
> --
> John Hubbard
> NVIDIA

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbOcdbAAoJEORje4g2clincF8P/3tH3MM9BAk1vtFcIlSgwgpV
CQo1zGcl889+0KwSERr8y3BKYaPE778TN2m6kUqZPiKJRBQ4AlmUCPR9KPAkvB2G
5JlGMcqBzFd13lfu7i6sG2mAA4inEvvf4Pe0DF2FH8bma3grt3JDLSIhbrk9bu1a
XEV8+ThFcjonsZis2Qr89aXiyvixorRblKWFmtKhlCZkeWYol08I0jk3UTkucod4
PCahPfSXuOJsha2KVLmLlbOH9cIaGHUzNkUtq/R61Fx64HQ/WbGJnIMXJFnDZtVz
o5JI1MtYBTib1j4e/8MaWb1b8CIgv9KoUtX3h8m/ySayRkkyTkdL8jtfuayOCb2P
zf6HcixfstiYaLxzl3QxyRNsnBTBTSxEmnZlK3BQ2/bDD3gP2D5FPpBEim2odSWI
Fh2djmRICd/rnWJVF9b5OUCQ2a6tzquRMVv2is5ogvD2B1pUPf2D4kSEoYA4IKd1
biYv0TL5VJn2DEUK7ldomhimbtji5dXaYocXwVkKzeuXRdkcfXhw9AbbsLLRacyL
78OtTp4++rQdVwh91pcyNibBYrTD/wVPe8KbIPSjXF1I87uzN76uzEVrP7UEute8
LYVHkPMItOpbzqDOBpmDq00d4r0abip3B5Aa4aCrutGsdW0OtaZ4z17Td96CcM1b
39VS5RZudMv3B1dY0Gng
=j7ao
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
