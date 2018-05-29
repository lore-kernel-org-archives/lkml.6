Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbeE2NHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:07:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:45992 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933548AbeE2NHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:07:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,456,1520924400";
   d="scan'208";a="45629331"
From: "Konopko, Igor J" <igor.j.konopko@intel.com>
To: Javier Gonzalez <javier@cnexlabs.com>,
        Matias Bjorling <mb@lightnvm.io>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
Subject: RE: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Thread-Topic: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during
 GC
Thread-Index: AQHT9mP5f7rVDC7vJkSDb4u0BKcPN6RE5hgAgAG7ZgA=
Date: Tue, 29 May 2018 13:07:05 +0000
Message-ID: <76C92B909A93A84C99173B331AB578DAC7AB520A@irsmsx111.ger.corp.intel.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-21-mb@lightnvm.io>
 <23C83C0A-B4FC-4472-B88B-4C7725F793FD@cnexlabs.com>
In-Reply-To: <23C83C0A-B4FC-4472-B88B-4C7725F793FD@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjM2ZjI4OWUtNzJkNy00MGVjLWI1ZTItNmFlNTliZTAyM2U5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZElLZDRFSEIyVHlxQVlDOWZ6eVY0T0dIMXA1WlMwbnd6disyUW9PSkQyelI5U0NWb1p4bXlxMGE3OGFydVZtbSJ9
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TD8JgC024581

> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> Do you mean random writes? On fully sequential, a line will either be
> fully written, fully invalidated or on its way to be written. When
> invalidating the line, then the whole line will be invalidated and GC
> will free it without having to move valid data.

I meant sequential writes, since this is the easiest way to reach rl->rb_state = PBLK_RL_LOW. When we updating this values inside __pblk_rl_update_rates(), most of the times rl->rb_user_cnt will became equal to rl->rb_user_max - which means that we cannot handle any more user IOs. In that case pblk_rl_user_may_insert() will return false, no one will call pblk_rb_update_l2p(), rl->rb_user_cnt will not be decreased, so user IOs will stuck for forever.

> I can see why you might have problems with very low OP due to the rate
> limiter, but unfortunately this is not a good way of solving the
> problem. When you do this, you basically make the L2P to point to the
> device instead of pointing to the write cache, which in essence bypasses
> mw_cuints. As a result, if a read comes in to one of the synced entries,
> it will violate the device-host contract and most probably fail (for
> sure fail on > SLC).

What about using on that path some modified version of pblk_rb_sync_l2p() which will synchronize all the RB entries except last mw_cunits number of elements?

Also you wrote about mw_cuints definitely makes sense, but even without my changes I believe that we can lead into such a situation - especially for pblk with small number of LUNs assigned under  write IOs with high sector count. Pblk_rb_update_l2p() does not explicitly takes mw_cunints this value into consideration right now.

> I think that the right way of solving this problem is separating the
> write and GC buffers and then assigning tokens to them. The write thread
> will then consume both buffers based on these tokens. In this case, user
> I/O will have a buffer for itself, which will be guaranteed to advance
> at the rate the rate-limiter is allowing it to. Note that the 2 buffers
> can be a single buffer with a new set of pointers so that the lookup can
> be done with a single bit.
> 
> I have been looking for time to implement this for a while. If you want
> to give it a go, we can talk and I can give you some pointers on
> potential issues I have thought about.

I believe this is interesting option - we can discuss this for one of next releases.
