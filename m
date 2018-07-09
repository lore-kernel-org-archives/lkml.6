Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D586C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D66A208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HZAvXbWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D66A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934143AbeGIR4m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:56:42 -0400
Received: from mail-db5eur01hn0238.outbound.protection.outlook.com ([104.47.2.238]:23261
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933771AbeGIR4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JTart2/59TLTLmyqXH0266FGKOaZPkhvp5FGrDSNBI=;
 b=HZAvXbWwEqjvySMeG14385RqSgTyOFSL4Qis9mJQP+3xnr8XzO9DcENmtoQPc5TMPCb8b+LRyDkdndPb2sSA2nJdyyWyIZAtMF0qN6Zpm0vhkL5i2Df67hK+rVNPV1dSsB1OkILOqBdt57iUjoH9BHH/3JkmIXvusyS3e+FeYKY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM5PR0801MB1970.eurprd08.prod.outlook.com (2603:10a6:203:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 17:56:25 +0000
Date:   Mon, 9 Jul 2018 20:56:21 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
Message-ID: <20180709175620.GA3017@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180703134206.27240-1-vkuznets@redhat.com>
 <20180703134206.27240-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703134206.27240-2-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0301CA0006.eurprd03.prod.outlook.com
 (2603:10a6:3:76::16) To AM5PR0801MB1970.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec0b9b78-31ef-4529-1ae7-08d5e5c54ac4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1970;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1970;3:kstiFC+nE8qeVtA9IY6YP6d2PXAjNLwJmAi1iIdXt83emvJKjoWnRpVNst+Pdb7EA08Q27TVyiYDLk5sopm2xo0y9Ohy18EH6ihflMv12irX7s2YT7juw9kBHTCaf4TCg+POHTaQ9DvUJFBy3ERnv+r2urVVVtci+ufOdenPXI8twcnuz/uvaRFo1h9wMVrOybKEEGen8lU2v4WIxRmjJhJKp0CNadpHB1rJm0/rMDcKE4fLIjYhv21PP3gm9uW/;25:qjI3lBtNkNgNBHGjUyN63Cl308ryOcAcVXjexzswMpGuIJdIF7lpf0R0SANVVD3Pz2/hfqrYH3cz+n/gahPaRpQr3ucmGhtyOu6QZ8GUmytaSxDHP79GEGUK2G/NshQ+h40g2N0glMfdmmx5cufVrbUyEkR4tZSJaCYukhm1j/3l55VH3KUtzf69Cafh+RzD4BLWs+51O6KI8ha/fSq+W/tcxD4SNDkrlyAUVw0KesPuZeGzb118U2qNVhJ0tMzH6RC40TL535+Sg97zBc6z8o1lTnAPg31LGrjWk+X1/cKdmp4DedMjrsNUOzmWc7ZGp0/FtS9iclSpxfNdn7uk1w==;31:GlWFEILdHQg6Kf/wSyomJfkm2DDh3NvYQ4DbWjO3JDAgR6IXQi0i3ObyPdy4nA1gDJPbM6+jf0pUdFdODSRFale1I7ehQrlhZqaWRgkFMLdVaeQb+3i1yfg8uSbx/vS79k66Y2FLoaVICoDBh7YaLdM2K/EWf2Jfw9SwQLpOhLJwhBMZU5dnK1ofHK/+v8TDuu1V2ZkqdQ+SfeXrq26uO9i3Lf2GgDccVPRlIKOIcJw=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1970:|AM5PR0801MB1970:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1970;20:VYBY1vxvlKmpBjUaqOu6AXmrwFmYuXRu5QEdvFq31lO1Eo1qSDwA/H7chiuDhe+EQleemTgQLwspuWiL5MrgAN8lgLpGL3xXMerqbjLHZfJHfEFgfZjS1GrYmjcnBa5bnVKiDmq8GwnqHTyGNOVz52cDogNSL3AgfQ+Qqyas5Po7E3QBf+dDug8QJu/mEJlJQczIU12EL0YYpDXG/MJDRJDGl5dYZrygD+eiLUqnR3G8VFkH8l+152VFrUyO7IqRHBhnqyAxbbmjCfSRhJOvsgoEyWu3vVViCuaw24Uc6nWzyeH7/VXZQJHLFqKs92d2TADRDYPsVyyoMT+kNzv38kCvYOR1hao36cv9DxcZzjP9Xgip7vCd3rh9SzGx53/Z59xiV61eb5WJ7VBPq9q3U+3r8Aae1C/Bl8+qu9X3CXyHZVuDfl5Dx0FRBNHZOz2WwpoCX6Q8Y4cAdQ4PdcF0NDLlUD5LD9cweuNGmeByqgwfhlg7BPhasDEM/8O9dPcv;4:Ro5f6XPr7zg390v8zmOCt6e+HLr3MoThk0dIMB6UHo68mSHuNvsLGQQOCF4FeMbqnjrw3S/rg1XaxsAK6RQQ/6HsUIa9DtT9Ahn0elNISaudIhCuzGzDnhDSV014xEsQAmN4dbl3oLHDU6u8tQWPNp729grfvOHedMZGc1qwxs3FWapRKuUPwk66zcNPiq32iGp/g1DNLorLLVKscfoFMHdTMCpRLEvTHMtzevNN0aESAM5iHpg4jGDgRoo3VKNWo6aG6cIkBX5kWlicgAVKIw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197024F5FD245C2007536BE0C9440@AM5PR0801MB1970.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1970;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1970;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(189003)(199004)(97736004)(36756003)(956004)(11346002)(81166006)(81156014)(2906002)(478600001)(55016002)(486006)(446003)(8936002)(86362001)(476003)(47776003)(50466002)(66066001)(5660300001)(229853002)(8676002)(68736007)(6666003)(16526019)(186003)(106356001)(7696005)(53416004)(26005)(7736002)(7416002)(4326008)(33656002)(39060400002)(305945005)(58126008)(105586002)(23726003)(54906003)(25786009)(69596002)(1076002)(16586007)(9686003)(76176011)(6916009)(52116002)(3846002)(6506007)(6116002)(6246003)(316002)(53936002)(386003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM5PR0801MB1970;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1970;23:yEr1giWk0YLsklmwKZBKDbyqdU1f8rcU30hWtPC?=
 =?us-ascii?Q?txwPaWANKaqp67BDSpd9s67R6Wr357MS4ACo1/1D3RWL08kTieGwActlRn3r?=
 =?us-ascii?Q?5sTVT4clAgFQ+xmXyf4cKqGLZqS6/Gic79ZmmGR55CbTzDimfmf6UgAgkN5W?=
 =?us-ascii?Q?GPNz0Eysqk7bojMEFA4q8DTbJfwQgVinBSOnvCUwa8E1GIQQnBvDsHzKRyd7?=
 =?us-ascii?Q?9FMTv2qgxqhd1QLbx7YooAg10ySiCNiF/utP5vC1XMaYN6My4i5d9L6r+pRj?=
 =?us-ascii?Q?20lVUlzPiid0hdVVJEd5prhN59/0DYERlkIcMJsSVyJUYPIg5aPxxKKUTy3t?=
 =?us-ascii?Q?gLi0aDKvAxQpskgBSP/m/Mcl4/9Z+hMJynfuQi3M+5gFxokOyfvwFOl3QwcV?=
 =?us-ascii?Q?KjwKWpAxFdSc8R/t6mFA+DR9hfywcCaQgWtD1+Tm+hdsMQphxkoxA7Zxdo+B?=
 =?us-ascii?Q?wQ+Rp0YZU9k5RJiL7fBG2n/ao/KwFU3Jx9pwywqSH+sQHpxDZEJ11uqkZpM1?=
 =?us-ascii?Q?f3ghDXqsWfMDAmp33t90jSXvCt1/WxmWPE5SGNu2fTiuYVXnCrCZAj8qhWOz?=
 =?us-ascii?Q?v1s28T+RoV2LADq3IB3wCIISnrEA6dklAZxpPI7Pygty3hrH/4/k/rLPz8+2?=
 =?us-ascii?Q?q+brYH7idiGYj7zjBKHMzOawe+xNJB5XCdI2KN6xT2FE9zYQFIZsMHqqaLhq?=
 =?us-ascii?Q?ZjmoNfAoOCAfPSkYw4Je+3NDDJZu6mZCklVySZGjEdqg2isIGIhM/QPtJ4lD?=
 =?us-ascii?Q?xCXYMeDdhqA1ZHZM85ojQi9AepSLVp6bPOid6luIzjz00eHDJDBn0iDPtq/e?=
 =?us-ascii?Q?G2slTVyCvJoc8JEOR5thZKg5fOlUZax7RE8Cb95gDKq9qttI4imq6kq0Vv10?=
 =?us-ascii?Q?jK9uST7uO7Hid39XIxwCVRqJ/B9M4SsZL0D5hQ/2BIkPnM/ed4LMJKDPtetH?=
 =?us-ascii?Q?S8MQsz/gYvdr65PAhg1zen63SJvXnUpvz9h5V8OWVW7WRvpZeYiF+AGrt93e?=
 =?us-ascii?Q?ViIWWtyjomT1GCLYPYJL5bwlkb2285VS/XFTCD/f8itNlD0ZSyqlHHEe4Yti?=
 =?us-ascii?Q?pvwl37yGJ2V0JS3Fp1etQab5hgCQNEMee2f838gU7WMTeW+en7XX6MvbaBMx?=
 =?us-ascii?Q?x2e3DWzMQtCFkln7OoPDuDH9V5xDC4Mt0kNgkBY5WB6tOi1kVb1EK1dGLjtZ?=
 =?us-ascii?Q?MANc7bkqvw0u7uXbz2J9KSs6voeWV5Wqt27HBnVX08ikAYD8dBLqdkTClgjU?=
 =?us-ascii?Q?cLUFtj0doGaQH6tEvrHqyi3Iq4qlJdLmV6yiCBuU6aWDCutNkLnh7dhb1XBI?=
 =?us-ascii?Q?NXlB+/Vq1/WilTXo0W2ciFEQOeuZVoHGZPQxwhYaLStSby/pOkP4RLBm4HXc?=
 =?us-ascii?Q?KUsldRV1/VIW8fsfCZYSClvWMbyz1B1FlgkMGobKSMJs4sloH?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1970;23:/TGdLr7I4/nFEP9iVCina2zNcbr77yyfAibM/PcyASkPM8/cSmeSnN9h6kr/nFQMsOVqhr2VY294OvwcHPD8aNMiLTCln50x7NlxTGS0vJ9T/sWhIyCEf9DsgZkfkX8fgPiGzEWIrgyYH+dfKH/NqA==;6:v45bKtBv7k5KHzL+A+KL8v2IdW+R2sLHDHTX0FMBVucEmV+kL63xy1NF9BozeJnZVHrw8OTvvJPqTkKxstELCODfFXNAmMTUiJ4ff22lZnT65iob2gbDdi4tKuT2aHld/tgOS6OLwY/aAGapLQNiAiHrc85AD0MO8FmRe+DdLFDCBcXWPMpCyuKqg2BtBrUMrw+0E6Ed5YldVY3YkJjpDNV7WQr5kmAvL2Sq4X8yAaVZnIzIb0v2GT5QyQGL6AEpDQtHgUJmYHqBz4jr7R5u2Ii6DJPw+IWTZyLcuX+RZS8xVsjPWBn5MTxakW2+dKoRfcqj+SdBNb0BHFVXJLgOpKqwA4HUDM+Vmo31oGi+GtpIh79z8eVfGS14iRBMhgHnT0uJg3+bVprobgIkaZMz2hihsSEd+8/WcHRCvtORz8xHm7lCYqFgze/AeUwScUqJVnTcp2CWrCqzbP7YysxmcN8aP2iVEIvDcieiwnyEAAHmr3SjPRMM5/aSz7B3Z76y;5:opHsHGK3Fo4GQ4s1lwIxq422N/Y5qkDG5TNuERnvldiKJGsRnTBmO1MLE+KcaXEUXZPBWSnQxIXs3sKI/kGn2wSCzqHAjHqe8VL5aatGnbJToR6o6vdoyn9DLX91Hmcrr/TsZ9rMH1NGFPjOkt55jqYFpmtHMFUwx+TfiUu8/+8=
X-Microsoft-Antispam-Message-Info: QCh6/eNfVrp2Z2p0bqpz7qkCXGg8Pe3/2DYFxlw912X1dXditN3wZpE92c3iTOrfHbbQ8gjou+cB5UZpaSILTYNG4HWyIRLuR/nj0khoBjYLHOxJKSijfV4KQs3mA+1h+Ze8M0xvgjyFpewV9nMRT7flrEwmJz62iSwWPTzCc5kqIfuw/d3PkwdPJoLxw2EFuHKidkmAUvuGWf1N7O/AOKyb+m4U0uWMvIqwgAQt7ehtwOnkl9aZqy8ZXJvJ200gtI8tGDOsAouNHTTbZnuDFjGjm7rumf7wZ9VPR6GCrH2xnFroGP40bdsqqw0L1sANUDR/ZxbYctpv8+KVTtBiGBL8Pg46t2TQViG6xxtIuenukRWvFq7onvzZXj5n+gMExh6Ohm9kzwbuOWGUVlsDofptKTcGyGfTuZWr9XpbdNWBKDtsLsDwFnZEAQjyaygwnRlYO5fVqehWUGIplwBcli3DapRJPJevnZM8Pt1L9wO4HmDaCy7KNxfbbBzTCSwBdw/e6SOXBPnZ15oZ31sx/0fQBdXjclA0f3q43wT0q1AMSQ41yicuUHMVH5CQWSoCSzLllTOFKlVOSe+jd7nt4w==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1970;7:7p1uPZa+2JlScogenA+Ohx8Ws71UUcuXBN6J7v99we9wVpxPDB4qMMsjZ8H9rFkDZNIJbcmbhmTPPM6kvD+C7C8Xlr9CdM1aQvFmFXafmCjaVu/X92ybR6RkJSItHxPiAepffFrV2ja4GuGqMHz0nt/VXr0vNjJ27RkHf1Q75Mv2Ibn4PS6Nv2jZBhJyUmYxIr91keegXOqmUolYZcWc2RP0ypN6/xC9Czu7GJU8VeyMsBmMLEkV3Vmaiydm8Os4;20:vBvuOHzoUNdqhCVhkLvuRCw/FdFwG4PQ4BuEVtUpu028tqJ7dNh0xGM33CWKmIHetkUlO6pGM1qkYyByGufj/WUr5ID1Y/pjKXbUIUtlVOHW9TZ7WFVNZZNO7fteAMD+K8bb9XsYBvGJrdIrMvh9Zv5g8+6xGxDmouECpyx2NN0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 17:56:25.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0b9b78-31ef-4529-1ae7-08d5e5c54ac4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:42:02PM +0200, Vitaly Kuznetsov wrote:
> Hyper-V TLFS (5.0b) states:
> 
> > Virtual processors are identified by using an index (VP index). The
> > maximum number of virtual processors per partition supported by the
> > current implementation of the hypervisor can be obtained through CPUID
> > leaf 0x40000005. A virtual processor index must be less than the
> > maximum number of virtual processors per partition.
> 
> Forbid userspace to set VP_INDEX above KVM_MAX_VCPUS. get_vcpu_by_vpidx()
> can now be optimized to bail early when supplied vpidx is >= KVM_MAX_VCPUS.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
