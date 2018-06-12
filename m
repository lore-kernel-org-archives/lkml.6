Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 246C2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D706208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WHmLhoYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D706208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeFLEfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:35:43 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com ([40.107.3.111]:45285
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753380AbeFLEfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFsa12NWwa4BOcKYSzZ5jGubCz03wlf79Vmpgg7PXfk=;
 b=WHmLhoYpKz6k90c1Xs5aEjte+2ZZ/R9siqTSAVDZnqi91BTuGLqg+wkfuTXtRhmX2jhVGgdzbDo56dmFEslm/tCr2S5ztc1Y2ZPQChRmiktU09plzPdyITkPGvFLRwS1mGv0UYjo4cRk537T/u02ynuvZ1K7KZcZyZX/V87cJmg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 12 Jun 2018 04:35:36 +0000
Date:   Mon, 11 Jun 2018 21:35:24 -0700
From:   Andrey Vagin <avagin@openvz.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/lock: skip lock owner pid translation in case we
 are in init_pid_ns
Message-ID: <20180612043524.GA8843@outlook.office365.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
 <20180608142712.32460-2-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180608142712.32460-2-khorenko@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:300:103::13) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:DNaDa9YnYy3FL0drXDqoHx/LdEhQYY8OzH1B+EKG+hRO0I53hc6H8KSiA9sc9WV4kEFAXV0yEMYua7jw1U5VUM6FR7cOP1f7B2+Lhby9LBp70AZMeZdfNXzUvdjiIUdgcAo3QRlbJ64S/2r3126vjfPn9GJTESubu4YRVnz+AsbyorZtLmlagEWxOoq3wgImcZWaHE533mhnWhpnbEFkrqNCrdkFJTIepE6oi6yWaGQmJRAKih3BsHs4y5QJBkOd;25:dQ8PW5dLyVLk0Iwm+Q45MfLphLtf26ZWHOXZbTsMaVfA8x2+qB6rmsyQQPcg/vF/T5J2AL2XnOte8UumxUOSggs6r1ZJi6OGWc7c3JJovHocN4Yyd58YcWtPyxVYt1CsGAdpXH6UUNQ4FWEP0IFbnJbNAEtv7PYP3bhSbHugDyynaVot6vwgJ8pYr5z3j5/mQriidvTRXtNfsEn1GoRn+jmgeOoKaLUwQeHUH2Thc6wOII/DbNhHb/IBY2v5XQxQuJni42yOl0T9pd9Ora/QWzwiwRWtgujO0SXplluXxf4YAPgMZmqCpL2V0Jwxpc/lcDlIcyrE2WEk78e/TWIjqA==;31:2+Wc+7xlAiFZNPd+36rEBG5mL+SpwA4WmboCLzsns74Vc48rTGx2O5Z7MpuDDirjI3H5szAkc8TaH4sPF6HDPEgeXb9f3BDqFnlVKNBuTQh/0CJM9r79Zec2hlapGxlmjDBKUKBli0CweicBhamuJa/o3EDPyiec4jCDUuBeS1y/cujo+TGy3+d0BPGGaziF74N2hwzco7nJNCbtuWvW1WwSbQAN54PHml48GPq8Ab8=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:4Jp223Jg0HLZdPW1L13vMCgvF/BihJB82/Reof/+OHZNkLTpZSCCU8djsQAllPy7/UGvXbjt0mgh7vtK0FVzKGFE/9D0TqF2Qro1DI2hQ3IjbW1xWD4SET7O2s8oSs7jqvuy9d9VY/NFmROavAu8a1foIJkbzoEcIKK6xRlC2Z6ci2vls5OTvAQuxQx/qNIGyEicgrOlmveZ5RQlBUviakOQRmX8f+lDaypOKaM/QxDdDcZyJ7UgdIJximbdblkMdHLyuiRMf0OXm1U0cuCvznE9/6BheA/bQuw5PN8Mlm/lI0qj6lOW1tnugLQdoReYwaSwTVf6myOoq+WV2mDHpeMT3kHZo93FO72OjlSWEtXxnxv33mlZKkD0NN1nA+8qMJ1KPURx6cA+aFad/a7jOvtqEvD7j0JlBaMsmols5u3iP7inCniLVeHbewq8rHX26fGS5FAJ5mtTeMz4V9bufNZ2waHlEzpyMiwgDNGyfct3/40cMQRK2r+njml1Fwru;4:CNGQ5qSB4HeGHB/LfShQYVlTX1tNXwxkhlhqrAC836x7DTR1IqSSSg+trqYeLnNifoIiKr//9qjckFL51ypQgCU59YzZ0i/z8inabqZ9frLIqxG0WAoHtqw0O4Gus0Gb1whO3TJQI/6pPZ/PRPfQigc7XBB3SCYoRFXgMgxAu8AxIt26mcOe96CmEXHcRHxI+Uwn69clvgmagBnevZJ6vrER8Fg5ZFUcDfa+jYyf5c26gPyJrbvzoseBRptfszz4TfbXkh0uIup6dZ9mvUcrkQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3254F6B2649E08C49A9020C2CF7F0@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(396003)(39840400004)(376002)(199004)(189003)(2906002)(68736007)(16586007)(23686003)(476003)(7736002)(50466002)(47776003)(305945005)(4326008)(9686003)(6862004)(25786009)(478600001)(53936002)(229853002)(3846002)(6116002)(1076002)(6246003)(486006)(54906003)(33656002)(11346002)(446003)(956004)(316002)(69596002)(58126008)(42882007)(26005)(16526019)(5660300001)(81156014)(7696005)(8676002)(8936002)(81166006)(97736004)(55016002)(66066001)(52116002)(76176011)(6666003)(105586002)(53416004)(106356001)(6506007)(386003)(59450400001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3254;23:0rPVj5kECLzwJKHj5XQ/YcN7FH/kFGQ7IWiKgBcy2UP?=
 =?koi8-r?Q?Tacm+XD4jOXRDZ37lZ45llIJkFKm3wYkR5v63tjijvlxWa+PVS5I0GOxxHUXMy?=
 =?koi8-r?Q?CWBOY0Nt4iruwa/m22N9+NnXhl8GuRG5jPSnOR251GI8weZrByFZHwojG6XypP?=
 =?koi8-r?Q?dvRyJGUkSG71NesuhycwkeN3Yw7i15snqLF10vS7NDHKYp1c2h1PSqwyCtb/rt?=
 =?koi8-r?Q?eEPUEdVRgI3ILlsxOWtX/bfa1Qd6VzNpLPsDTaCf51UMpEVxBskQc/jFd/aGGG?=
 =?koi8-r?Q?yDfZECNuOgQ/7q0FisbJeAkEoPTKTC3xC1xxnxxxOS63jaAUDci+Id5wHiVIDg?=
 =?koi8-r?Q?vJ0uAWR6mu2MrgE2FE/7ckmOCFk8pOLv7YURq8SHe9pMjZ+opcx6PUA1mdd2XE?=
 =?koi8-r?Q?PJ+Rfj7XSQ1w8486KBN4m3OAb01rvg02jOhdDLa7G2ieSSlOhU/6qqBixBEw06?=
 =?koi8-r?Q?zHsDuiBjcVK7RF2KBvVOCm8tfsp2aZY8N+FtHSMGfKyzshWm06qdjatlU+bJna?=
 =?koi8-r?Q?GS1d6FbmEmHWGZ+5KTzPQtwerdrjX8wcMiVTISF1o7Z+s+wvNXsYAqiHvVe2bP?=
 =?koi8-r?Q?sGx/jYLYaoQ0g1cL8PKeVjOxYIgOIySoKuHZOQTTeU6kM5Fv2KAvPxSGu6En6L?=
 =?koi8-r?Q?2K1fIRok50zIcW+cmKoiSoPWZrpxIqE+Ld63eyqCAgUaew/o9Onrl63r/FWRwn?=
 =?koi8-r?Q?RSVFYPatCmt9C2hBqrUK83wgee4nRjpglJl6usEIY+AAaL0zx8GFB3WUtQNRTK?=
 =?koi8-r?Q?dB9K1CRjT4qfgVFj2ZAkHISaZGhCHUgCtM9pzQ0ycKx4wj0x6/bs4pV0lwd8pO?=
 =?koi8-r?Q?G21DC952Jl7CeozrpZiIC9xIy6oAPfyN3754xXzpBh64ULWHRyLwWOxlBm6ad7?=
 =?koi8-r?Q?Mi4BiO3I6qwsgWC/fBHINcPwYPOGTBfg28FjklIrCT6mF2LDqKTXJ4s4KGEAWp?=
 =?koi8-r?Q?E12sLNqKZi9ez/nbeV/hbOVrhMmYuRW/qHEtbb7TRiezFj5SeplDvzqB4x04ct?=
 =?koi8-r?Q?7GwOI1WdOmXfcWvKtzbugnic+BbSpJEgGPmc/gy6NHx3VlAmlNSQIgwDz16LCF?=
 =?koi8-r?Q?H6pT1obtnNvfg3zHss5NLo1y3G8WkEpIUcvbLcIQ1y5urOOpNt9HCgkXtKqYSN?=
 =?koi8-r?Q?D37hpHnggRahLCgx0qEsg6A5wPfNeGJNtWDctBs3CZxnIZ+q4oPz4hAiM7g9qb?=
 =?koi8-r?Q?c/RyErpdfLhFq6EAvmIWDZwyQ9x3y0dgZfjX+gowferia9INZtXkIEAQHULwZH?=
 =?koi8-r?Q?/VDRHvUlA92GbDMbTzr72GhhmadibbJqLn0JVKwA=3D?=
X-Microsoft-Antispam-Message-Info: GOUaei4w6DK0AeXaeG1MLIdjD9YEJcH5CjozKCkxR9dPR1Fqze1mnBpJFlS+CHtkM44u7sUTmGeKkTS+a42l2Bn+mMSz7v/jcioBr5GCsC/o4xIQrUmArJdU47dR/vOaOE9SUJU/vXOX0vrAleZBKgdCxXSqCF5S9//ZP5jIQ0Yq7/fWSawFE+IBooU5Gbae
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:u0D9WZeqo652/O8aML3FSVG6jQhQ/WUXmcEhF2yfKBl1pnxgBBd7NmuHoH0aTaVlUD10bhKaqaZ/0Tpal0rs+ggY8GHLuZToYvfqPdITKTWFWZz/8p5S9MeywRSavOpMA9m5jxywFt/3FFGnQFY0/tNUUbJ8pzZyR/AHFxRZ0D5uam/SX6MZRhqOKjdoxSiQaVoczRBwUNHzQFoAKRClfaXuVO4MaKqUN9OsPy3QW0pVst5+DLb713IzbrbD4PoO7yxQTUT0XGa20c7xjSq0s/tEYx6hCcfc7RTmT7058sl0UQqCwJeoTMkSfutdWoQrXYIYOFDvdz92s4L9LUKnWozJvopJnKAGTpA7vZ+kD8KftLTyKhTzG+xp+mTh/SMc/BHFEcgYUWG8Ont3LF75oYVrJJMZMt5H3EXZObHMULA2u50Tki7IpE5Elx7v7RxmPlm0TQc0dMB63DgEZYzp3A==;5:IVzPh/1xqypCBACoG/7Pel+AjyfvtHxGsA5ddrxmsUWVJJWGXWhqg60Rg6CcXHVHyYSjHavfk9StfKJ5OvZSjNyF97HJKvy9U17YCc87jS4OLOTWpdnNySi6J1KsWYVWtcZmb8N1wvJn2QtUVE4h3+8GWSytLthb34pjd6q5310=;24:Ud7EtCOIVNMu5sbmDcRVTPLreqYrJqdOuxOXLXkL7rKZGm1moahEPR+TX4QNWSD8ILNz/Z0mzIvxcgDXKbGXVsSM6OCuON5V6yaLvOdKZL0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;7:Np9O8XFQ3LWLXxCiDVzfcmvl48eqZeF/Gya10iuienACo/GSUIb5oN6NzTjepzrLHAXz1EgcTfg1ZVrW49ia8ELb6QeQRSsgp9Xi+H9RdT1t95a3xv8/KQ1qY7QdMrpk+/y8Ezze5AK1KnA1HIetE41CheNAmAbbYbHMiGwXFvNYJQa6p7F0WtadhnCBhezVtoIuFYGjwv41QbnrfI98fB2GzWxoZfmqjfUuQUih5VoQAh2IzA3+R0KOh1LYTtWq;20:T2CBvPlMMmKuXsymfsIXyfzzaNqVkoMIY6j1d8uwRTGqo7NzKO9VM8+QPYvLPYau0ZIGGrcdQPpW+bAtZRCbYgV2JdJtpNz1ujqk5VqAvOvd/yeuFjMGBsXQyismWZFLRauXZVDyVvzTu/kAhC7eaUESrEgnAAVBbTebueTCvIg=
X-MS-Office365-Filtering-Correlation-Id: 3ed62b89-42f2-4a79-3275-08d5d01df279
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 04:35:36.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed62b89-42f2-4a79-3275-08d5d01df279
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 05:27:11PM +0300, Konstantin Khorenko wrote:
> If the flock owner process is dead and its pid has been already freed,
> pid translation won't work, but we still want to show flock owner pid
> number when expecting /proc/$PID/fdinfo/$FD in init pidns.
> 
> Reproducer:
> process A	process A1	process A2
> fork()--------->
> exit()		open()
> 		flock()
> 		fork()--------->
> 		exit()		sleep()
> 
> Before the patch:
> ================
> (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 257
> lock:   (root@vz7)/:
> 
> After the patch:
> ===============
> (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 295
> lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF
> 

Acked-by: Andrey Vagin <avagin@openvz.org>

> Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  fs/locks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 05e211be8684..bfee5b7f2862 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2072,6 +2072,13 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
>  		return -1;
>  	if (IS_REMOTELCK(fl))
>  		return fl->fl_pid;
> +	/*
> +	 * If the flock owner process is dead and its pid has been already
> +	 * freed, the translation below won't work, but we still want to show
> +	 * flock owner pid number in init pidns.
> +	 */
> +	if (ns == &init_pid_ns)
> +		return (pid_t)fl->fl_pid;
>  
>  	rcu_read_lock();
>  	pid = find_pid_ns(fl->fl_pid, &init_pid_ns);
> -- 
> 2.15.1
> 
