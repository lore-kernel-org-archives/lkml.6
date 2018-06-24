Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C44C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 17:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB28252AE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DapaFZ4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB28252AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeFXRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 13:08:15 -0400
Received: from mail-cys01nam02on0092.outbound.protection.outlook.com ([104.47.37.92]:11881
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751920AbeFXRIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 13:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXt6DxQcusbsJ46qcQujNV7xe9qzyjTv+eTdKKdgG/A=;
 b=DapaFZ4us75yPsLhozc+DLMamlHYrS77QV58ml6cnXS8T+Xdrnmv7aqahALNCOncSboH9GPUK670NC3nap410+s0mOazlxUCPFwY/XJVLM+4ip2a4kgq8MuCz8+KAPfibxnTIwJV+4q1+UR8sTkKnT8xCxVqOehOm82IU53rTtQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (2601:647:4100:4687:76db:7cfe:65a3:6aea) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Sun, 24 Jun 2018 17:08:10 +0000
Date:   Sun, 24 Jun 2018 10:08:07 -0700
From:   Paul Burton <pburton@wavecomp.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH for 4.18] MIPS: adapt to rseq API changes
Message-ID: <20180624170807.3ipztwlqkozff6w4@pburton-laptop>
References: <20180624162513.28264-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624162513.28264-1-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
X-ClientProxiedBy: CO1PR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:101:20::11) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f831802d-49ec-49ba-73e1-08d5d9f5108c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:gmcCqfzp1UolepmM/Sylox2HfDLyKb5MIm+ZTKCNyYMzyQEzgg5wKqbJZpEP/03Z/fQwL4I3RKTnftMc8EpNZEQ1oFcw6neVHrmJbcnsbRA2XOPEVM92gh2SdOHfZAxPjbGSe8+qM59cX7648Eg3dotOuMHGolp30QdBwkSFgrAn9TFxMnxb+ChqJypzKSNsLBTOK0S38dwgP8saC8wkk0QBn2VEuWYUAdZmS8OryCfiYw+SenlZWdqWNo7He2L1;25:3jwqyFgYBCzrv1lKsF9P04ivjLKHsmW4lOYkYJ3cBp6jKXRwRda+X525NUyubogkb/YQSQ1XvPLntdTWnnHhVFP7jqtXTpYkeOFMD+Bs8h/IciMVkOHFGZPGXViJV2w/SoB3/SFffjSSyhucNKS8CwensiTDsg+jQLH9LoungNUfbIf8tcyenI7K0LEoyPiEdAg4fyd23A5FzCJ14wpc2UFHv5/3xwxpH2pqPM9e+2bRa3Z23ScUD1zdYvKKSEPLmtsCdQ7ORNAJPsm1cr6Qhq0r4EyNB9fV38xmnnfzK5aeXHHIaUYBE5NhXxircs1m1lTUGe05S3KexsHgngdtHw==;31:wyZuj4vkYo40Kxqwa/BqvAnbP+YNkRymTU+WfVtb5Cq5sPyz3LWj07y5Q0v7hQeZMAcycMo/lDkScLfvXmVXYaH/n0N8emRc+FOSEeovDISkaEzndSV3z2PSZmaZwpN0uliyFwnTmX2IpxujZilwcFCfX8s0qTk5VH67TizfFcZtEFaD4FAR0tA/D01Px2tNL4IeD9b2AL0ob/QyCovMOKA8pFr1yvBCLA0sJK/oPPs=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:BhhWIJ4RnOX+TpzZ4TVWAyKwUPzFR5h9QEfka1KSpxkcsIhIYj6ehwRntc/yTr2EFZnk81akTFexeqLJu4tdPbPI+9TGjZq7IN+XRdCwU/+TtVd9USvmlnxAm8V4wAQuA68CN/dAQp7yj6y2JG/9b0+x2QeBpCyASwMMyisWGtyDH1nC+9QqEjmSH/6JnuRMHZCS4PZeC10RYcB/fUEwt/vuM0GSFrF++/A+UKcj2QAOAFF4zzUHNOnJv5Xiewmt;4:8/wP7bWPUFGwbyWxg0RyKz6LMN3J6lnif5B8Z98S5tAFOSimsH6gaoyaeDTrtE7sMOAdvIX7ag6FjSVQElPeE9htEPDmV+XyqcY3BoO+HPiYp3HUN8NBE53q5Q6GeLZGwoOejCjOWcutKVP8qaU3i2f9G+QNx80NHNDixT2KeGu9dB/knHV1dd2+ZmbUJk0FhYO4yfmLF3R7C2j/zcnamsxGHAs9RAh8BaZ1enl8oIe69bL4jaMLmjm/cQSHlA4vKwwhB9HxhnzmVYS+IWxRnVIEOPQLBuAX8JO6xmuHD9tThZLOJH/TYLyY+awV/cy4Pw+nvOjDyPRQSxJt47e4NuvkK0xj2TUldNVCcQ4/R3r029jWLBnr+vXDEFFHME18
X-Microsoft-Antispam-PRVS: <SN6PR08MB49419C3116EC645E7810B38BC14B0@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(85827821059158)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(346002)(366004)(396003)(39830400003)(39380400002)(199004)(189003)(106356001)(76176011)(105586002)(478600001)(54906003)(386003)(52396003)(6496006)(316002)(53936002)(50466002)(52116002)(58126008)(16586007)(6246003)(446003)(39060400002)(305945005)(68736007)(7736002)(229853002)(8676002)(486006)(76506005)(476003)(11346002)(33896004)(7416002)(5660300001)(81166006)(81156014)(97736004)(25786009)(6486002)(46003)(9686003)(47776003)(4326008)(6666003)(6916009)(16526019)(186003)(1076002)(23726003)(86362001)(2906002)(8936002)(6116002)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:wWCCUzhsDxF60m/i7u6zW0urY/PPYe6Y9pIUDsBep?=
 =?us-ascii?Q?FEGTSwaVYQqmp5a2U0OO6/cmjCyqAkw0b99v6JXssOyoKuWYyy4Sdg/Wf/l7?=
 =?us-ascii?Q?5Dr2RVJdbc7KCD3FGjmrlBWWZQokp/yKj4kMK45DQuVY01UCeSre+bVGgrAx?=
 =?us-ascii?Q?FMFueekSxOgbAnjKOxzOLBxonlChQ6Ig3XPHE2017TRiVEr0J6augg7lx/TZ?=
 =?us-ascii?Q?lt0EDkfyFNplyvQPgrWq74o2Mh3f5MbcQYdRbhMk7YFLVCcNwvno81E5TOIR?=
 =?us-ascii?Q?ckBEZPxxOM+H8/dQC4So+/4KhSZ204RadZC8xkPg4TfhsGjXuBDdtACfYKN6?=
 =?us-ascii?Q?J2j8EXlsm5rP7qXiHqw835GA/wqe2KF2PlpgFCd7zAVkNJb2dV7qiLtkQD6a?=
 =?us-ascii?Q?SdQTrS5nzVeHYymS1fbTWEhmAHj0Jj02/48easNkghZx5bzw7UyR5fyoG3ss?=
 =?us-ascii?Q?KeAp7F3PRxXsfK8+Nfhd+WQ0z9XWuVWfCnqOqGcVtEMCmP4eueTogUJ8Oljn?=
 =?us-ascii?Q?E7HfYj4xUP/TaGaA0AblWlZMoNqWu2+GdD7i/XJfVYZgVvjA4qOlziVfO7mo?=
 =?us-ascii?Q?ybkqsCTB+jayf1Of0E0ECXqGWUT/l4yy1OhVfGPfYssgfiHhNdzSIsgDmVlB?=
 =?us-ascii?Q?Xuzr9Mh5ixJmcwRrfQDJE7cUujQ+LJpPitV0FP4PYGNTImFZDfV1kbVqVcSB?=
 =?us-ascii?Q?eohibCL2Bxz69R+hIKyPgLd/jDN66DG7eee8398JP9SilrxMUNAPFOlfrVa0?=
 =?us-ascii?Q?8NN82Jf5qE5AuocCRZ3Bywnqi1WHR+yZwj7QyZstoPrRFmZRCfeRxzttHqvT?=
 =?us-ascii?Q?mTvncfTGoSFswuuTpph0komU7Fu9xz4DZYZf7Zwdsk4+7DdsS47DnSNLY4r0?=
 =?us-ascii?Q?Ht0TsZlsDQtTyVM1nLjD+KHntHmVekOpFjpHlIsjITmmL0kgoZ9Y118Tq7Dy?=
 =?us-ascii?Q?2wRAjfQ6eqKHN9CFpDD5DLLyO4LAXZqLtbZJbu08phiwRySSj7kULAPAltLk?=
 =?us-ascii?Q?WwKeGwfavJDM4OI+STdiSBo9fTwCoFcO6W7F5drypzbpB3FipOUOpjiZnSS/?=
 =?us-ascii?Q?a7zjXhxXnHlI+o1g3cgsZsEnelY7316cLOPsyzX6pFFuSwkhDnpYUCPfHCfW?=
 =?us-ascii?Q?0eqjPkrPWFaqLF1SSoq7epNSP27+KRgEpYlRiak7EiF2Yi5X4jxOhEjXkQE8?=
 =?us-ascii?Q?KniVu0KkzHwVrPruKDjB0jNE76Z9obH44+S5qHMpfdGTSXNYR0WEZrfaTzBg?=
 =?us-ascii?Q?2NYc8bXY6m5SrNp63uWvjaWpuiQDVhsrzl2HH03wlSyKpbrucNWqNcl+open?=
 =?us-ascii?Q?K7sWEBaRaixh00ECHMuYbc=3D?=
X-Microsoft-Antispam-Message-Info: weavhVy47yhxsbqd8umM+cY6FWtoLxrxl1Y279y53z5BPLdoTAQjiLSkAUkz2Vxy8dl5PBETXqRBZyBUv9yltF3Nd01R3HEeb2HBr0yDQNKpQ9ZRgySaI3JoLH+kODtQ8QbmB+d4l+rIwdU+ziLsCS4C1jnDREQGEMS+zgTTXRUP42TEStqpib8adyG0NO9uJcxGsB4XEBdVdF8zz2TUR3UUXzD2axvKXBiRZf24rgHOIXLkcZ1JCJb12Tt5kExh0PwItJDHInNDK3EKeH+hwyC9zUxOBn0XtYk26ibc8HWHQASgB+D8Q70SJ8gWf129Va2F/n1H7q7e3RguGP7LMfzJaRCODxk2tEa9O8gAYgY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:EX6RoNio7AIEes5K21zlcS+FEmJdwfT9fxY145kG2qTgbfjxtaoGFFz7GA3J7gT62ZajaFKRofb4jh73SowznS2UxBAfbf30WXfHvh5w4muIEgO/AGhd/VV6vTdCqlqVukHgNudrjBCjPEUlap1QTBsaFZqyg+yEoUz9g8Riph4plrTdakgVB8kzdfPrNV2uHrhoNiOB6oru1kf/4JqkPR+YA3AweRiX5BqX/B4q3PR0g+/raRd0hdA4jetxL9T+aFKwIeI9SuWpjqfQtcX75D5a1RnJVV4pD/A4dIeJOgzZgzHrQKqs993yHQsqyZXLmfzeqeh6y9nBf0lN4hx4DF6RJ4X05JN4znjVvNAlTgvtuITL6qDpoFVvN1qvQc1MRysT0QbctAWWAg36y1XxA6okogFn2ba5Jp+Y30/z63BOasCfyiOxUCVjtApGn5kFwtjXySq5Uo+i6wFzNBq7Ig==;5:xuWSstodmpklUyoHw5+hUGRseFd2VbM7roYI+yZUy4HSx5DJJqxzev37B7FhwbQkCpdC000cR6KjzeD1rG9HuFfuCQW/YnscTlVdeROG6ul9BOVlks9M+9fL4KWpO8g9czqSg3LHoZK/EKC6RKfW0Q74JalM613J4YoLecghrPk=;24:8CALPwnWNXd91T+FV6GQKxZ4BUOq4iEUEfOxTY5TKt4IF4ghc0SWlGFaQG/kCCS+rLxJEQBPL6hOVjHCsSt7mmrV1M5omtY9SN9W1uLF4Jw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;7:xxhGyhg/VIurPSZf8AyJPXcl11NLmCtO/w48/ONBhe23NaLyoeDMmx92q89vu9Obh1109n0v0QqteL5utpw1QwENmWc1qjkxghg4T86/xCXuqdAdL8oykEkvhRILvO4BxOA/PHCILhOS9wdlYtWUf11+a+LXOmUYSRt0cxKNTSThn2xFYbdmBIrzCfsFPSTGeLeDSgu1FO9QJEehLxnVmdMuE6SImuPhG8q0R0ghbrzl9DcZ25jA3XjXHeFtOz/j
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 17:08:10.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f831802d-49ec-49ba-73e1-08d5d9f5108c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Sun, Jun 24, 2018 at 12:25:13PM -0400, Mathieu Desnoyers wrote:
> The prototype of rseq_handle_notify_resume() and rseq_signal_deliver()
> had to be changed to fix handling of traps occuring on signal delivery.
> The API change was merged at the same time as the rseq MIPS port.
> 
> Adapt the MIPS port to this API change.

Ah, you beat me to send this out :)

Pushed to mips-fixes.

Thanks,
    Paul

> Fixes: 784e0300fe ("rseq: Avoid infinite recursion when delivering SIGSEGV")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: peterz@infradead.org
> Cc: paulmck@linux.vnet.ibm.com
> Cc: boqun.feng@gmail.com
> Cc: linux-mips@linux-mips.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> ---
>  arch/mips/kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index 00f2535d2226..0a9cfe7a0372 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  		regs->regs[0] = 0;		/* Don't deal with this again.	*/
>  	}
>  
> -	rseq_signal_deliver(regs);
> +	rseq_signal_deliver(ksig, regs);
>  
>  	if (sig_uses_siginfo(&ksig->ka, abi))
>  		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
> @@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>  		tracehook_notify_resume(regs);
> -		rseq_handle_notify_resume(regs);
> +		rseq_handle_notify_resume(NULL, regs);
>  	}
>  
>  	user_enter();
> -- 
> 2.11.0
> 
