Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEJSm7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:42:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:42478 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeEJSm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:42:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="38350579"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: Achim Mildenberger <admin@fph.physik.uni-karlsruhe.de>,
        "olouvignes@gmail.com" <olouvignes@gmail.com>,
        "jayanth@goubiq.com" <jayanth@goubiq.com>,
        "ehabkost@redhat.com" <ehabkost@redhat.com>,
        "postmodern.mod3@gmail.com" <postmodern.mod3@gmail.com>,
        "Bart.VanAssche@wdc.com" <Bart.VanAssche@wdc.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] e1000e: Ignore TSYNCRXCTL when getting I219 clock
 attributes
Thread-Topic: [PATCH] e1000e: Ignore TSYNCRXCTL when getting I219 clock
 attributes
Thread-Index: AQHT6DClJ3dQ5IHll0yV5BCwEp6jIKQpTMjQ
Date: Thu, 10 May 2018 18:42:56 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882DD85D3@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB5882D918F3@ORSMSX115.amr.corp.intel.com>
 <20180510072835.5549-1-bpoirier@suse.com>
In-Reply-To: <20180510072835.5549-1-bpoirier@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzljZjgwYzktZDU0Ni00OTU2LTlkOTEtOTg5OWE3YTRmNjNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjlkcklGaWVNdmplRktWRG50TG5LWUxMbUVwYjRQZlhIVTRVbDFZVGs0ZXM9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Benjamin Poirier [mailto:bpoirier@suse.com]
> Sent: Thursday, May 10, 2018 12:29 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Achim Mildenberger
> <admin@fph.physik.uni-karlsruhe.de>; olouvignes@gmail.com;
> jayanth@goubiq.com; ehabkost@redhat.com; postmodern.mod3@gmail.com;
> Bart.VanAssche@wdc.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] e1000e: Ignore TSYNCRXCTL when getting I219 clock attributes
> 
> There have been multiple reports of crashes that look like
> kernel: RIP: 0010:[<ffffffff8110303f>] timecounter_read+0xf/0x50
> [...]
> kernel: Call Trace:
> kernel:  [<ffffffffa0806b0f>] e1000e_phc_gettime+0x2f/0x60 [e1000e]
> kernel:  [<ffffffffa0806c5d>] e1000e_systim_overflow_work+0x1d/0x80 [e1000e]
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
> Moreover, the phc (PTP Hardware Clock) seems to operate normally even after
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
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index ec4a9759a6f2..3afb1f3b6f91 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3546,15 +3546,12 @@ s32 e1000e_get_base_timinca(struct e1000_adapter
> *adapter, u32 *timinca)
>  		}
>  		break;
>  	case e1000_pch_spt:
> -		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
> -			/* Stable 24MHz frequency */
> -			incperiod = INCPERIOD_24MHZ;
> -			incvalue = INCVALUE_24MHZ;
> -			shift = INCVALUE_SHIFT_24MHZ;
> -			adapter->cc.shift = shift;
> -			break;
> -		}
> -		return -EINVAL;
> +		/* Stable 24MHz frequency */
> +		incperiod = INCPERIOD_24MHZ;
> +		incvalue = INCVALUE_24MHZ;
> +		shift = INCVALUE_SHIFT_24MHZ;
> +		adapter->cc.shift = shift;
> +		break;
>  	case e1000_pch_cnp:
>  		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
>  			/* Stable 24MHz frequency */
> --
> 2.16.3

Given testing showing that the clock operates fine regardless of the register read, I think this is probably fine. Normally I believe the register was used to check which frequency was in use, but it doesn't seem to serve that purpose here.

Thanks,
Jake
