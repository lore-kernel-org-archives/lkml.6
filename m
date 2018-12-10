Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E728C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D620851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PZwNzzBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4D620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeLJSE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:04:29 -0500
Received: from mail-eopbgr720129.outbound.protection.outlook.com ([40.107.72.129]:48256
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbeLJSE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnFKO5kZaesGnnb7szamDbfs1qEMEMNVlvMABZWNO6s=;
 b=PZwNzzBDn+l6dsVN6msnjRfxFuzSzfxrShlb7t2H8JQ9aV/MD7h0kAbjoxs0w6tryKcK1zLI5OsjBBpLLhHCBccT7bkHwfLmcmXLIA+ae0R8dZCc3gnIL8ypzIHlxUqdIk2Mfe0gDevHpWoRLVkoeXrb+aO4nGZ1NEMPnLJzbG4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 18:04:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 18:04:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "strace-devel@lists.strace.io" <strace-devel@lists.strace.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Thread-Topic: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Thread-Index: AQHUkKLEXYd9kptdykSyYkmtRZu+ZKV4REeA
Date:   Mon, 10 Dec 2018 18:04:22 +0000
Message-ID: <20181210180421.wq3ruldbpvu2jpfm@pburton-laptop>
References: <20181210043126.GX6131@altlinux.org>
 <201812102200.snodXJSH%fengguang.wu@intel.com>
 <20181210160940.GF14149@altlinux.org>
In-Reply-To: <20181210160940.GF14149@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:104:1::12) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:ZWAYi6jwzCPsAnSJZZJFTwfCI5RePm2Fp8nOafBeaM6v1uH6JBZ7rAYVxFHjyGaIJGgigqK3Bpld9KQTE6LQSvM0eh/eL31igT3j1vm1F+DnyE9MAyevaIwNZKLPCwObwuyyrBLVQac2A+hB6Cn6ozW9QWqpQTMb9MRU36vPN7O5zghEJNVASkZN951SkGVHkEeQePocCq4zRopKikhfFeMPDWcIcTmg7Z+N5yThtu8roJJzp2SmUlJjjhmAwozREJAFQesPa5onHpMwpDWXkQWFpG/PylWRmqTPS1QNm0dJM79CpaWPK3E+eOkcX3VFqeH7vaD8K6bEiyTcs7XpU7CqZ72PS4hr3B8xNxYBG9bT+BQydzsDi0E9qppmt/ms3GgltZo7UGnTKbyx6Prg4aQ/y55B/6v32AVU2Avxr1OjelHPH8D+D8cUsnoXbP0OGrXjOwHysjsxW4Vv4IW80A==;5:Tid8zzgpdxCdjRWOnQYnbsgkZQ9DiZcXwQwGOtFtzGviVH8CeZhEHzOSbPh0hubXRZAhkXOgkV8tk/ABAk1Ke75qeJjjf+A00Vp+DlcFWSY6yZyUmFL8+7zyED6d/gg3n/Rfz/7A3RF33mOBsOKl0UpEmknCX0YDlWe/M5S2iBo=;7:I0UnxtGFhY+0J2KfxL54tMA1IBM+nuqeiJ7VtrAVKKvbs0XmMq2cZk2bVFmICTLjnreqC0muP6rRc6WIBbQaoL3mpqu3Dp7fhWyFGPoxugA7k334S3s9EtQV/b+v824/Qr6odrtHvNAH3QiwpRAXuA==
x-ms-office365-filtering-correlation-id: b638b032-1464-41cf-cea2-08d65ec9e9bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB14399AFE9FA843AF00480B85C1A50@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1439;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1439;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(136003)(396003)(39840400004)(189003)(199004)(386003)(1076002)(3846002)(6486002)(6506007)(6512007)(8936002)(81156014)(102836004)(316002)(76176011)(5660300001)(33716001)(6116002)(8676002)(105586002)(446003)(66066001)(229853002)(106356001)(14454004)(7416002)(52116002)(305945005)(9686003)(81166006)(4326008)(54906003)(7736002)(58126008)(6246003)(6436002)(186003)(2906002)(99286004)(68736007)(44832011)(476003)(11346002)(42882007)(25786009)(508600001)(486006)(6916009)(33896004)(53936002)(71200400001)(71190400001)(26005)(97736004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UeQAXgkP7qFv4fl5MNQuuVksvllYOnZ4DwBY2crkFfEaA288xOU+yRzTxzwtZIAHES8KNMNg9Pd/pcGqgatJ6/nFH8rr39wsRW4T0o8os/MOeZe4VqKvd4BMq2yYinmLTNGr4U8HCqMn3NeUf2Y71q7aqHQcgCQkXXvzqwvW+CxNaovKO/Bc0XeA3l8vhTiCyFMGhu00etKtEna6qQnv2N2cWrQ30nhrOZgZTI4guTYKS75EWKmKiCRMgP1nUeTseEuRj5y6zF7P1HlcbtlyZ/vQOZh3beolLd+G6WB8uXGX+ywnOUVUVQpqog3UaJ4U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA5D44B8C785D448AE71DFDDEBB696AF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b638b032-1464-41cf-cea2-08d65ec9e9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 18:04:22.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Dec 10, 2018 at 07:09:40PM +0300, Dmitry V. Levin wrote:
> We decided to add .frame_pointer to struct ptrace_syscall_info just for
> consistency with .instruction_pointer and .stack_pointer; I must have bee=
n
> misled by comments in asm-generic/ptrace.h into thinking that
> frame_pointer() is universally available across architectures.

Is it correct to say that you're using frame_pointer() purely on user
register state, not kernel?

If so then one option would be to define it for MIPS as something like:

    static inline unsigned long frame_pointer(struct pt_regs *regs)
    {
    	return regs->regs[30];
    }

My concern with that though would be that providing frame_pointer()
unconditionally might mislead people into thinking that the kernel
always has frame pointers, when in reality current MIPS kernels never
do. In fact a comment in MIPS' asm/ptrace.h seems to suggest the lack of
frame_pointer() is intentional for exactly that reason:

> Don't use asm-generic/ptrace.h it defines FP accessors that don't make
> sense on MIPS.  We rather want an error if they get invoked.

Looking across architectures though MIPS isn't going to be the only one
missing frame_pointer(). With a little grepping it appears that these
architectures provide frame_pointer():

  arm
  arm64
  hexagon
  nds32
  powerpc
  riscv
  sparc
  um
  x86

That leaves a whole bunch of other architectures (16) which don't have
frame_pointer(), or at least not in a way that I could see at a glance.

> Unlike .instruction_pointer and .stack_pointer that are actually needed
> in strace, .frame_pointer is not used, so from strace PoV we don't really
> need it.
>=20
> So the question is, does anybody need a
> struct ptrace_syscall_info.frame_pointer?
>=20
> If yes, how can frame_pointer() be defined on MIPS?
> Or should we just forget about making sense of frame_pointer() and remove
> struct ptrace_syscall_info.frame_pointer from the proposed API?

So, along these lines my suggestion would be to avoid it if you don't
really need it anyway.

Thanks,
    Paul
