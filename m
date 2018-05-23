Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeEWAob convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:44:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:34869 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeEWAoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:44:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="57630843"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "ehabkost@redhat.com" <ehabkost@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jayanth@goubiq.com" <jayanth@goubiq.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bart.VanAssche@wdc.com" <Bart.VanAssche@wdc.com>,
        "postmodern.mod3@gmail.com" <postmodern.mod3@gmail.com>,
        Achim Mildenberger <admin@fph.physik.uni-karlsruhe.de>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "olouvignes@gmail.com" <olouvignes@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH] e1000e: Ignore TSYNCRXCTL when
 getting I219 clock attributes
Thread-Topic: [Intel-wired-lan] [PATCH] e1000e: Ignore TSYNCRXCTL when
 getting I219 clock attributes
Thread-Index: AQHT6DCtUDdppdXIbkmUH97qUqERPKQ8jdnQ
Date: Wed, 23 May 2018 00:44:26 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964D305D@ORSMSX101.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB5882D918F3@ORSMSX115.amr.corp.intel.com>
 <20180510072835.5549-1-bpoirier@suse.com>
In-Reply-To: <20180510072835.5549-1-bpoirier@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Thursday, May 10, 2018 12:29 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: ehabkost@redhat.com; netdev@vger.kernel.org; jayanth@goubiq.com;
> linux-kernel@vger.kernel.org; Bart.VanAssche@wdc.com;
> postmodern.mod3@gmail.com; Achim Mildenberger
> <admin@fph.physik.uni-karlsruhe.de>; intel-wired-lan@lists.osuosl.org;
> olouvignes@gmail.com
> Subject: [Intel-wired-lan] [PATCH] e1000e: Ignore TSYNCRXCTL when getting
> I219 clock attributes
> 
> There have been multiple reports of crashes that look like
> kernel: RIP: 0010:[<ffffffff8110303f>] timecounter_read+0xf/0x50
> [...]
> kernel: Call Trace:
> kernel:  [<ffffffffa0806b0f>] e1000e_phc_gettime+0x2f/0x60 [e1000e]
> kernel:  [<ffffffffa0806c5d>] e1000e_systim_overflow_work+0x1d/0x80
> [e1000e]
> kernel:  [<ffffffff810992c5>] process_one_work+0x155/0x440
> kernel:  [<ffffffff81099e16>] worker_thread+0x116/0x4b0
> kernel:  [<ffffffff8109f422>] kthread+0xd2/0xf0
> kernel:  [<ffffffff8163184f>] ret_from_fork+0x3f/0x70
> 
> These can be traced back to the fact that e1000e_systim_reset() skips the
> timecounter_init() call if e1000e_get_base_timinca() returns -EINVAL, which
> leads to a null deref in timecounter_read().
> 
> Commit 83129b37ef35 ("e1000e: fix systim issues", v4.2-rc1) reworked
> e1000e_get_base_timinca() in such a way that it can return -EINVAL for
> e1000_pch_spt if the SYSCFI bit is not set in TSYNCRXCTL.
> 
> Some experimentation has shown that on I219 (e1000_pch_spt, "MAC: 12")
> adapters, the E1000_TSYNCRXCTL_SYSCFI flag is unstable; TSYNCRXCTL reads
> sometimes don't have the SYSCFI bit set. Retrying the read shortly after
> finds the bit to be set. This was observed at boot (probe) but also link up
> and link down.
> 
> Moreover, the phc (PTP Hardware Clock) seems to operate normally even
> after
> reads where SYSCFI=0. Therefore, remove this register read and
> unconditionally set the clock parameters.
> 
> Reported-by: Achim Mildenberger <admin@fph.physik.uni-karlsruhe.de>
> Message-Id: <20180425065243.g5mqewg5irkwgwgv@f2>
> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1075876
> Fixes: 83129b37ef35 ("e1000e: fix systim issues")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
