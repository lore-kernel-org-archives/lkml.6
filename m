Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3533CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EDB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M7v834rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EDB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeFLExu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:53:50 -0400
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com ([104.47.1.106]:48544
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752665AbeFLExs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP+O5OlsPICjj3XYm4EkClZIz/jTmDJycI5YuSsC00s=;
 b=M7v834rmt4v938TNINcAJmnruGgQqbCkZkAh2xBIXGkNJRPO/urz7F+OaK4NuKOB3K0BRuTOg31dH8QrnOGINTjHI3nT0T8y3qJfSPB3kMxkO2UdBhgt0xsgv3MEFhxiNhuyLEJ6xR9shbLbXBIghwiZjUXwnxw4q737z5/qJ38=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (2603:10a6:209:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Tue, 12 Jun 2018 04:53:42 +0000
Date:   Mon, 11 Jun 2018 21:53:31 -0700
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/lock: show locks taken by processes from another
 pidns
Message-ID: <20180612045330.GB8843@outlook.office365.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
 <20180608142712.32460-3-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180608142712.32460-3-khorenko@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:300:ee::22) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:WHmHsfq+plthYP9zFXZjbfvXeXhzkyvapLCSUqIqFWxCDWciNxtdSMUorjvaNgJKID7dzIM11x9gDjTzXzuUeq/ZZb1yW1omQwjfxOpmhIKqa0qGrdPpA0clZzlmWneE7ZphQYHOOy2JUXjkVGUDxXPWkJt3bIh0Qo7nTw279F3ya5/V8nxpTLYw2536mZqNRNeTFf+xnky9XAZsZhWat25FKBVy+jXxVizrEl+0B4NOL4FX/GHzTfonfvPEBr23;25:H2SWnQ1R1klElxCUptOVcv/miy4XVBPomJY4AHjnZhgh8nLCeeUIIRB2YtvGCojKWAVb5yTbwhz8Lf6fT5dLtjqVVxl/UOROolPtDb5e4jRinC1AXES1VEywPObMurBoDtITpnlj/OaZwwP68pcebXJE+SDYV146/0MEsTR3F+doEJ33pofKhpfgWvfRB2HRD8YrX3+yCfanL+nZG86E2PjWthuM8t1LGQRfd/5/zWp3Uqt9TlizVkm+GB0pKqpnxIaE+w2VQNNydEkiAa+Y0/y8bSEAzMa+K2b1Hmpc5QZxb0KS8UXbDePwRR0fiQ1YfScFXV82GvB2BWw11zxxoA==;31:GZ6AZFPYkPy3EWE0+68b0jkcex8hYP2bOCA2UzqQNGIy79x5M9TWyaoMyQvkJlfumqctEkAdWSp1hmumxLWCicejBK8fpoTApXhH1oAZp3wjRAQIbMuIQd3QPsHekIlVD3VSNrbLnmI69mdUS9+jC5KPdXaC1666pH8quGgR0tXE1HqAWnnSBvsxkz4sUahUMZUyAmrVhH/aSK0FhkCdj1VxDxRSel+SJSKd5QJvSg4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:OxzMR9sT2+AvqB7hrIUXjaZyE0jjcvxNFi0Lwf/pIWRqQEMu4HvIWwz57Hd864wuJnIT6couR6RRhebeQ3ya178cRTn2Btum72Bk3kJeSx5sGl/9Le4FosHbUwSno4MG5XsMX7iBpdaMznksPNHDaGC/+tadLxjD4ZODNR9YxdaHBca52Xv4BU9Itn7fNFniLy2720K4Fl2QFX5EbwaOGTfTRq6YptibrIPFLNBI3pM1erw1O1nME3RqmV2KeeKX9M2wjPkDTBMyQ7NR72aA7R9+wwGIYthTRuZgRUtKzwvLHpEIywnY1RQMPIwaw5y4InfQ151X8Wypz5mFOYllXx1AXxK05/8g5AC9gNfphldRl/9esWvrpcHuKVPxgfg6M5CZHJWiTJ5oogf2uz7/1BSchZWjDl8HNv0CMPNiAsGwVemOMpdXMth5h3aJQ5eCCnkjF0dOOX/Nfhw2ac3ZbM/PGgw2h1d4yfd769ytsrCSxCvaXNH0An5LyXJMtCki;4:PHUdQ9YEsMgwgtI45NQ/oTvoapkj6aEBxt+B5hydDZ2K21/+slWSAjAwl+TeKNW8Pda9vrbIErNBCKgTnyRAJgYBkKsizcmRZ5++4dedSsK+5S61KLR/Rp1ysdsl0s47kUQ4i+X9w70knuYSKCZ4dEHRiVqhi6SA5MrL1m73g1i48x1Z+ORE+3GJHCiB5+ky40pbjnHPUjeRnNpwxPSSQOs3kN3Gt/RN3A2u+7RbHBprVycqnC97tKKXR+cqpny6tM373ge5G6tMQ1yjcA7qtQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253E174663B384D933A416ECF7F0@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(39840400004)(376002)(366004)(346002)(199004)(189003)(54906003)(52116002)(7696005)(26005)(105586002)(59450400001)(76176011)(8676002)(478600001)(55016002)(7736002)(6246003)(106356001)(53416004)(305945005)(386003)(6862004)(25786009)(4326008)(23686003)(1076002)(68736007)(446003)(476003)(486006)(11346002)(53936002)(956004)(33656002)(9686003)(229853002)(58126008)(6506007)(5660300001)(6666003)(16586007)(50466002)(316002)(47776003)(2906002)(66066001)(6116002)(97736004)(3846002)(81166006)(86362001)(8936002)(6636002)(81156014)(16526019)(69596002)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3253;23:tq+nSD9IrQpT3Y50VBjX5KKPMfIxYQoK1E11nZPeczY?=
 =?koi8-r?Q?q9UIwqJoe5IVCzLvtWgtqHQKO5M4+d4eS/MtQfoDzvx6FSCmMCD8alCGIdUDmq?=
 =?koi8-r?Q?OoSutPYk1oTxJ4BaTcrphOmC+gjvZUo6fYPxMmF8JpbPpaxhF0pJJWihVIk/52?=
 =?koi8-r?Q?IGJaJbc9gtb/X1RNcodIXNaC31enkPmiFx06jDvvCjLRldoQ9h5pKVrPVDU1uJ?=
 =?koi8-r?Q?05Tav81kvFQGuaa5pmy4wZKb4ZPpXw1LFr4ovVaiL8iiQwFgooObdITXnOIblF?=
 =?koi8-r?Q?TcEo2JKyhO3wp4CUBMGu5KcXa+XpGXbRjfikEqGkmJdgzCK/wXDQbEZtGdpxjE?=
 =?koi8-r?Q?FmFHT2COWgCRg5gXcw6VuceuHzHRqB4iSVnqyRmaX/V/29RzZaRT7Pp98wYUmw?=
 =?koi8-r?Q?OwgG6wfHLJc/xmeJiW3ZA8zsTBOhr0TGI5Ur20iWWx8leVseI987hutM9RdndG?=
 =?koi8-r?Q?DD+QW/uMmBFmVgrGn79TX22pWIx3dUDtB24lHs6kh8Pk2fmC5uUyIXkm2eMLbQ?=
 =?koi8-r?Q?VXpTfQym7PbaLFd64Oz3MXclALfXCrUCQlRFe8G6NhXe6ppIPHVv8wYh1Riuma?=
 =?koi8-r?Q?JfyyXnKvryFliZoIa+VYau7pKSWdHKaiE1R28tiopQquxd0u2ojoJuBn4k4Atj?=
 =?koi8-r?Q?79zl3yrQytNuufBIYcGniaitub4LfOaWSgOXizAZx6xqa9V4cXFwDukugfhI76?=
 =?koi8-r?Q?5dx/Ceo3vA3VPKPXlV1+iquMkJKp7ttpjs+O5QFQqkScsc+LmkynSEi5Jx53X/?=
 =?koi8-r?Q?l4MlvGX1XHRxs3w0eI8Mj9Mq3OdKc3lRyKv9Xft1d49+s9O1s4sJMGAU/1Dxf0?=
 =?koi8-r?Q?y+9pxrdzb7eDg+fzSEouGyubWjHDneDUAyh68b6tkhRaeUZvPZruTgAc7gSbb0?=
 =?koi8-r?Q?ajiNJ2egkTEYJE+HFBxyG/0nAbFJkAWAJw5LAtbOSlv5sOz9/TYLmOqq0LyDZE?=
 =?koi8-r?Q?dBbcgq0o+6YGqHmJLPGytsK0SOl25eZAiSMa2Lq/vLa33LjefNG+clwmioBtgB?=
 =?koi8-r?Q?sL+8JL17+bY/c+dDHZUEGflFfbWpEdZqewsn26c3cBRbnxnVqKoKBLA8be4vo3?=
 =?koi8-r?Q?MRMrvXcyCnA9YWDX2AXRMJccwAqEf0P7sgLcbo/yVl6upjS3IS1QJff8pzbYf1?=
 =?koi8-r?Q?7yqw5GfqEKfNQLyYqiHRlSthngM0TZ8/I+nZH3uTwO30seqv38R1NKOlqe7YcT?=
 =?koi8-r?Q?0572YNVrNbsTB9pyGswGpKMexfLhZYIQHkkoBOTcvk+mcr1Kx7HmMseVU72/Im?=
 =?koi8-r?Q?O9T5PfIwotpVpvL/mY9gPdT4VU+cGfeApxnYJ8mtjoc3gpR5AaUEnAiD37aP2B?=
 =?koi8-r?Q?skGxiWI5jSJSMDtW3+b4LtgLyUayjhD16PentKmD3w9AxFIqGFV2/E7xcsSvrW?=
 =?koi8-r?Q?8BQFWSnq/K9RO27JNY9emLRUV+LlerB2Da+syCU0c+Ds=3D?=
X-Microsoft-Antispam-Message-Info: sxPYgNqTce2sJ4nHfZ4oUYCplQxYhxvBcT+kdJk+tGZtJbQrbFbm61BnUgSoY7Bx7tV9+YdpEFup2v0YYhzHIZnypyNuDY/LsqRKKUXEHptxc6wNIBYZmQvBCLTHDPu3lp5eVtIxJe5gI+K7WQ8FAnT8ia8pMGeYfiWfdIRbBI8/mXyqZMQZ5o3OgbtY16cB
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:+ajEimWLb57Z2czPyEnq37bj4QNrgr3hnudR+BJizDVHPyEFM+ebmawCYOT44jtLBoyTIbdJaNj63dRhEZiUcRn+RKKFnrc0l0Hc9zO5aKV9RhR4zAR42tondsmlvq4ziIAzSoBdAzYcHogoFU1/mw5qTyuIGGvr/Iz9j8DdpnPCqWAbSIwwLTYBNR+yrACbDKc0xWV40ZiaYKPlnDW2qhH+nIbAvClFlNFtiGQzQGEbwAaIKnxrVzHhu/LHkTHUX4KzmwZrtGltCdVEn1qIB7muCZqQDChIHv8iz0X9P1SmPM6yBqo42M/wpnRMh+fcInpieKcXYbrcAEClPvqNklV3+u+X3+GGNC3MxqthvrTTdGPARM9KopV/PTVW6zkrwdhza5I797No/26Gp6m5/GsF0jcJCp/I5hTowKP0aVFwMynSoB1YXsdHg4eQBgLUksFsQU+1EaS9hzJxzoVyVg==;5:wWeTC1STW+8bpY7Oms08g1rI+L2/dSNIZcTlWvIn+EPq9TUcrQu1bOPcbDNagVDN9P+cfuvEqfV8YUcUYGcXhxz/UwGOPTWcEl8LvpyWw8t5GLVNzfH74TBHDtYnYIcI1vUnH0MDJVElBBVg2ilRL7qyQG45cfMXLkbXyNLzqgU=;24:5mdLAtmIvWos/t1DaOweRB2kzzGI+f/by2Y2hOkK/syCinWrv1GzuIDCh8Ir5DeHuM2Ka7foBz13drTsJtGRYr+ccG9FqEH5uXGDrecfgJY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:bEI4HIiyGlZCxQh41foJOpKaoVw9ZxiGy3cEHh/dW0FXtsNZ8uvjZAfSElj47SBHfLYg45DMUZKeyPlqB1s9eHe0T6tMh3Kz2NyqpG9kvTp/4dPx/iu2wKK8tVMJmgy8OCFlWElzzRIwxq9sCbNibGwwyhGXT18gQyz7KXApqnhs7Tiu6HnF4rDtpGA9T0N63PcrGh1CTGHZs1QkkNyGofYYapXyDTeFROOAJ5xhn9Mw7jz9ZRvc84mEpTVRiK8f;20:QYzYI0ruztnzvcW3Ug9ddBVdICTSy2DIaas7c8mj1eaP6ZDIr9yNOrDHxBVRVSb9YQHfss+RKRIrMBPc9ET4HmPN9RB5E2WykPyjQP2zE5SrQTcuuK9qbEGDBoJosTgQMkWXvpxovCEyRMgVPD0avkB+WFt7BTZvwXwzKEXG6JM=
X-MS-Office365-Filtering-Correlation-Id: 8e90ba35-f02b-4c66-f41e-08d5d0207a06
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 04:53:42.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e90ba35-f02b-4c66-f41e-08d5d0207a06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 05:27:12PM +0300, Konstantin Khorenko wrote:
> Currently if we face a lock taken by a process invisible in the current
> pidns we skip the lock completely, but this
> 
> 1) makes the output not that nice
>     (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
>     pos:    4
>     flags:  02100002
>     mnt_id: 257
>     lock:   (root@vz7)/:
> 
> 2) makes it more difficult to debug issues with leaked flocks
>    if you get error on lock, but don't see any locks in /proc/$id/fdinfo/$file

3) breaks the CRIU project. criu reads fdinfo to dump file locks.

> 
> Let's show information about such locks again as previously, but
> show zero in the owner pid field.
> 
> After the patch:
> ===============
> (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 295
> lock:   1: FLOCK  ADVISORY  WRITE 0 b6:f8a61:529946 0 EOF
>

I think initially this was broken in this commit:

Fixes: d67fd44f697d ("locks: Filter /proc/locks output on proc pid ns")


Acked-by: Andrei Vagin <avagin@openvz.org>

Thanks,
Andrei

> Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  fs/locks.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index bfee5b7f2862..e533623e2e99 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2633,12 +2633,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  
>  	fl_pid = locks_translate_pid(fl, proc_pidns);
>  	/*
> -	 * If there isn't a fl_pid don't display who is waiting on
> -	 * the lock if we are called from locks_show, or if we are
> -	 * called from __show_fd_info - skip lock entirely
> +	 * If lock owner is dead (and pid is freed) or not visible in current
> +	 * pidns, zero is shown as a pid value. Check lock info from
> +	 * init_pid_ns to get saved lock pid value.
>  	 */
> -	if (fl_pid == 0)
> -		return;
>  
>  	if (fl->fl_file != NULL)
>  		inode = locks_inode(fl->fl_file);
> -- 
> 2.15.1
> 
