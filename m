Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80A122552
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="SY5gLJ4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A122552
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeGCCuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:50:15 -0400
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:59895
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932120AbeGCCuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIiXAK3gxdu5xJ3Yrs1yrK4jiFdPuPngyNc2wlwEyRQ=;
 b=SY5gLJ4KWT73kQ3hWG52bWHZlN60PwUYN+xErzEwAXZRTl19caKtNqEbMwdMVZmgkudd0jaMzax9/mA+GezELptBwt5TwPbuJLCZAccxUwwCbzMlTYqRfbJgGRYrADzlcATmCmG2+d+sWPVv2liyobYIRd5QdSaFnt3Mhuo4m0A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2634.namprd03.prod.outlook.com (2603:10b6:3:43::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 02:50:07 +0000
Date:   Tue, 3 Jul 2018 10:48:16 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Message-ID: <20180703104816.031abbfc@xhacker.debian>
In-Reply-To: <20180703102257.678db6a8@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
        <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
        <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
        <20180703102257.678db6a8@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:402:1::11) To DM5PR03MB2634.namprd03.prod.outlook.com
 (2603:10b6:3:43::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d5317a-d318-43ac-5ca1-08d5e08fb098
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2634;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;3:pPD9H/2tBjiWt0cX16gDdsQwHIOOhA4utfARHkwaLbWr7Dx/3qfq47Vj7gx5LS5EAUfhyHm3FSarw/OFV2sTsgjNMQRdTE+a+t4E4OJRpaN+5ESeq3Nzjm6J78aA62vN5CV1kfymxCiK1w9Djky7TQ1bCiguiU8uZc12lp9JlELaxhk7RsnoHHRxNx41Nyfb+GXJPTTFS9Gem1SsMtq6++K8jj21aclwiMBdOdtBE/O1pnQN95dyv1PbNfFVrAgR;25:WmYjQ4Sj8hyR7A9n7q8wDLu9jkssFetItbYe2kG7xlGPyJVJlhtZPNa7EPGwSg8ZSB9SYIsISNJENVfE+auwQA0C2zpGhpY8NDZszY26G+tnabEPZLOClpks0ZC/pd95gMfz296ejy1loAS+WvMTa/sa31cE0zbuHbnwEv6oSJDg53KbNBdDmacqO8Vb1XumbzprlrhUeFG5xW9P66WDy0Wy4VGqf+6p0teQ56UvxovyWOZhFJtSr7q1sCg/NleGw440tAFvsW0lZbeaSEY8vVmrBS+X6tjN5SJr5/hYwwfevaIiY+kaV/cuJIQnaJSVFv3MnIt9D/Ss1DjohL/k8Q==;31:zH9HgxrJ5l32akLEwVvgaImsnHl8D//lvnD0y5wiNNEko8j3UfAXCKhJUqxyilclpUsV6GSHIYi2FX+SkIV2VTSoJNlmxqPQ9SdA5UFRWbIqzWpOiE106nYvZvvY2tHizME4AeveIIO517vmfDfykpXHMnGmRIhMy1yL9Dkv/MTd3BqEQnIZmZz5cjm6T7vSRgJqxcZ7Xdr8r8CbdoDR3kdZunEUOscgFqVCYIL6fng=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2634:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;20:QVws2AWr5Rsq+b+6RL7mqnoWD6jyVNg1fRQXabSza2KRxDekKOgYePM+LYh2Ta+oTyzorsSfYuCvbagWDq+3Kdsj4gNsWHKbkBV01srcllgiNTe22kzretaR6ZklRc8TIIa87oTlEP9EhX4Dw7K4JF84BCMd8IwvSDAtfFIuw3NJc/YUYcvwdtZ4dt1eHT55y97e+pAPZXCJVqNuPF58XyvoRnpvl982PeloJUDHSUjDCYVWCDWSYu/52xAzN+FLfp4LXOV6JcmNP0jLWsQhHfm5Q+Z+P4PSsc7lF2oxgr92h7HLmX07F0mwviDTU5D2tG8awPzF2r4xhlR1HpOqh90g0InFxXVwSuUDyOCTaz9Z3qi8jUwnDHFA2BtvhT2CnVLjztM8yRxr8EQiVCoA3OSi7MWp8ICmHa5z8FnUiYt/DzTxpgKNoAhkcKg4QYLYUrTf6pPwqC4eQUOnJfvNaWWoBBv9TpqyVcnrjtuz02X0UVImkJ/WrL+QElx/O8HX;4:YcSPPkzZJL6tX+P1eK+aypPUKc+9DIod1yhf+T3MlEYgbB4kcgDVc9g6OyQe6ka7o3KqbOa2AuOXB8j7+TIeY6+dJlvvjTn+SwywqCHGagBWBj8RVk9RA515vTUTUWYUgb5TM+UDqe6jTg/EqEaepEvKdeMbm2YnJeI+FXQEoYpj4KMeJK3BdcWGIRKDtaWHvCVLOVSmmJyH66zALvV0n1ZcVPPIU0FndCihFbXRybEvVhNb+L0ju2/NOjq2gcHcWqW3S6M99mnIxkeqmPHNwQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2634123EABBC9B3895C8FA16ED420@DM5PR03MB2634.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2634;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2634;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(446003)(486006)(11346002)(476003)(105586002)(956004)(305945005)(7736002)(8676002)(81166006)(81156014)(230700001)(76176011)(8936002)(52116002)(7696005)(3846002)(316002)(26005)(6116002)(1076002)(229853002)(23726003)(106356001)(93886005)(54906003)(9686003)(2906002)(68736007)(5660300001)(86362001)(6916009)(6666003)(66066001)(47776003)(478600001)(72206003)(55016002)(50466002)(6246003)(6506007)(386003)(186003)(4326008)(14444005)(16526019)(33896004)(25786009)(53936002)(50226002)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2634;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2634;23:R8BVMYPYNL0URFnJ5jGim6e4Gcs9lOj4Xtv98x7n8?=
 =?us-ascii?Q?P8uFPfms2czmSKz3RJWNSBiDF/HeCy88zZRt5/JBNO/pEUMy8/W8DkG8RKsS?=
 =?us-ascii?Q?PQdH/oVLWsayZNaIMg781gY9ckLIPLN/+aooLO1kg7oknXGoZUekeO7KaKfC?=
 =?us-ascii?Q?GWARsK2LxLVy6igplGW7IMYaSCVsdxsKLdUMxNqwVRhqvUvQNIXCSNS5kPr/?=
 =?us-ascii?Q?sL5s0eqLbo4GmSINzGTdJFKLdxaEGlJW/OGFk+2WaEJTGsYGUQZWEs6NdBmo?=
 =?us-ascii?Q?Q0KQ767kPDpVPqh3E1wFOncZQYkmQ5z99ZAjMMLwwR6DlnV7G7M/4puZj7FE?=
 =?us-ascii?Q?JJHNn3BdDTE27LphEnGeFZGl+FSVdrf0aP/EYkwOuDiyVekgABkhmtW8Es8j?=
 =?us-ascii?Q?QOWyJIkUDe2nRz883QE/u1ifxbPUiad4IhxUWXczVO4i73pln+WPMq+HUovZ?=
 =?us-ascii?Q?t6BGIXNFhotAuTPg4cvh8oBXD+iAGWciyfNJl+MDn/9Q3A1RD8kKqsHQjOYd?=
 =?us-ascii?Q?s5Sf5K9jJa3sqz3eviMeC25p82/hRhsBxnjZ/a713ONvJDFyjiOw+984Vu4v?=
 =?us-ascii?Q?gvFOaozEtRAmeiPUeqgHpmsvuJZd05pE6byIvwVcWMa6PMKpYAiPh7jIR6bw?=
 =?us-ascii?Q?DY1uuOJ+A1LPPnrYYhhziLdBypmlBzIY0Ffj47ePc8OVuaArPgbeM+qo4MLg?=
 =?us-ascii?Q?C4ntYOEi5P7qSg65cU0ArFMxC/Hd37yB+KFIe8wfMnHpv17Zw/5kDYhb7Ft0?=
 =?us-ascii?Q?Blqz7VV117XL52t04PJjjbIqZ/TOSiftAc252D28A4ek5BPfj0YsJ8mH/rdk?=
 =?us-ascii?Q?7+mmuIvgRmXyFbZYmJbj5fS52UsFH/PSf+goVmcfg6Sx2TPsbaSjHGkZjKFI?=
 =?us-ascii?Q?UrPvrsNoKQLSrBPgQv2msAkDm+V/ZLi62A6c9oXAWew+fJlxeFSSSYgOxkDT?=
 =?us-ascii?Q?vAFa5tIAbtnIGNCFoT09V1msWe4rFWkrGErhBTf1CmsZnBQ+2+JcF0kQPcoJ?=
 =?us-ascii?Q?qGhjJKaKV1kkAXYnTvV4n7MB36RLQvIVZvY8RsYd/rsHCwxrfnlKl9eatB6i?=
 =?us-ascii?Q?lxZ5XIBC0r9/M63LfQXOp24CX4ZJ4/6eUvMo1it4FYriIx8GqhkygtJN+Zih?=
 =?us-ascii?Q?tBGXAN0Xg+zpbtnRujgWcs27lLAJt0Pc+/0TOD4D2inM9wKBlkZa+MIW8ulV?=
 =?us-ascii?Q?Z3R3NyB1yXPYWo+v4AompSNFuczz8PqX9Hhmezyk+idUKy3huDtXZvx/p3Oh?=
 =?us-ascii?Q?+Q8wgj4Wsdsxrp7wzHXPgPhCXOzLvhfnzoZSjgjuhAJy5HAXc/BamvXN12xD?=
 =?us-ascii?Q?k8M9uDSp5gXQ1Sef+ys8ws=3D?=
X-Microsoft-Antispam-Message-Info: aWsgfLLLIk+RSBLU7aGw0M2LNKOtAAwV5DBGDi/jryIW4e3VxcoJ2Xv8OyJNEBYZ1egBndJWOcs7BE7KSP3+kNHjjDfN7G4dPwWfs4Ur1QE0WNk+pf7HuMdpBk7tVu8y2380am3JbidBL+Z4ABDrJqrK7fuuMOT9rEYMYcVuJiJRFd25kH77ggiCKq2H6w+X7rd7zeliLywyCMs4vETrIuIcylp806Nd/ZwA4TH9aehipucUnpGxys2dba6uSOfQ0T1JJAR+X5ZC0EHwNKoLIZYVhpFD9jTFuordRUr809aZDsfvqeY0qpHm2lrQ5Rsb8o/Y6+KfvB3WGSIfswbX9DjvVrueqyA5mNXj9UlFS3A=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;6:XNCGPxkKF9oTFwkJppu1CKCelfGZj1zUzBZ4Qm/WFx37J/2Q+CZF1JYEbRFpI5H1UbaaBRTnzePJ2fe++psysmAtaU2u6Dxy3XeWy2DXC0vpmeKczeAfoz3c5NCYcz7vV12NDOMIsSZlVbm/7+q5uiF11l4iZlvn8zkIHANAz2GBpbGlS1VI2KmNH6Bccojcs5lBJk2K3o5CRXGbJz8+D1vSFA6R+AI/o6eA24tnc7yjrpEApuDAcpH8V33/4EbPsxrOuFBTsywpZJm0zIGIJ6Nvtf1DeWzujo5fDYWswmlMGi8si9BEL2V10uvrat7UM9oP8cpR3p2ca6K1V3GjXVz1IvA/4IVIiUfgDVU5CrqYRCAxnCNYVxA07e8rUNDAhmSrcO2iEKxbum1/FgIDUO+GZe4cFferW2EWNXCocOsG56izpuB9z3kd2ms0j1KLK8HsPc9kWtmzKGsweqwSFw==;5:ibscg7NZ1CmJxrN/cVhDpZd6B9ABrvp5sWjh2YWP5M6Wr7qVBUfaoGqEeB/AQ+foyWRkTYqWnraR0TdThGJgNAKkYWOhPoJWdVktWe4tRcz6VR6M8inXIFG1PY43Of4xl3jC0OIevF8KvfBgwR8ctsaJagC7L3pmO5bfccZ0COE=;24:jPqvtWNWjZoHqjSaJM5zdIq7Qjue/x7hBVsgm3JLN9DURAyvVpFLeV+5hj6fdJRWa4yxzThFnKpL8LwGFIr2qjx08gycAm8L5jrFMGRSXZA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;7:AhuVxHkeoG4/Ua0YQLm+KuOwV1+191wvThPCMGRQZBgKqVz3XIBCCgYgKSCGypV9iUDxUpoef/iBDvwB0a96Zr+somTVOOu+O7MgQlwuSFgc2rPvJDmThn5dx5ysRp+Roi2XyJ9xYNDDxvddCIMoLMXc0CDZhfzvcsgC9yPw8KklFvSrGtRd+SjHxZ4k+Yw3Ib99OUkvf0Yt0twmaO3jNgHUg00h9BG9A42HQc6cLS41Oiq4pe8BDwdDV88Z9KZG
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 02:50:07.2988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d5317a-d318-43ac-5ca1-08d5e08fb098
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 10:22:57 +0800 Jisheng Zhang wrote:

> Hi,
> 
> On Mon, 2 Jul 2018 14:51:03 +0300 Andy Shevchenko wrote:
> 
> > On Mon, 2018-07-02 at 13:18 +0300, Andy Shevchenko wrote:  
> > > On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:    
> > > > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > > > valid divisor latch fraction register. The fractional divisor width
> > > > is
> > > > 4bits ~ 6bits.
> > > >     
> > > 
> > > There are several serial IPs that have fractional divider built-in.
> > > None
> > > is using any specific hooks. Why do you need in your case, esp. taking
> > > into consideration that we have a custom ->set_termios() callback?    
> > 
> > Okay, I see that in 8250 we have hooks embedded into 8250_port.c which
> > is not the best solution.
> > 
> > For example it prevents better splitting Exar code.
> > So, we would need these hooks, but better to integrate them in the same
> > way like it's done for the rest of 8250 ones, i.e.
> > - rename existing to have a "do" word
> > - create new functions which would be a replacement that choose between
> > "do" variant and custom one
> > - not sure if we need to export "do" variants (at least for now)  
> 
> So you mean add the support as following:
> 
> 1.rename current serial8250_set_divisor as serial8250_do_set_divisor
> 
> 2.add a new serial8250_set_divisor which will be as simple as
> 
> static void serial8250_set_divisor(struct uart_port *port, ...)
> {
> 	struct uart_8250_port *up = up_to_u8250p(port);
> 
> 	if (up->set_divisor)
> 		up->set_divisor(...);
> 	else
> 		serial8250_do_set_divisor(...);
> }
> 
> could you please confirm?
> 
> Another issue is I'm not sure which struct to add the hook,
> struct uart_port or struct uart_8250_port? Currently, it seems that only
> uart_8250_port needs this hook, sure, adding the hook to struct uart_port
> is fine either. Could you please kindly give some suggestions?

patching struct uart_port seems a bit overhead. After reading the code
again, I propose another solution, similar as what dl_write() is used in
8250 core:

1.introduce the hook to struct uart_8250_port as my previous patches do, 

2.rename current serial8250_set_divisor() as default_serial_get_divisor()
then introduce a new serial8250_set_divisor() as:
static inline void serial8250_set_divisor(struct uart_8250_port *up,....)
{
	up->set_divisor();
}

and point up->set-divisor to default_serial_get_divisor

what do you think about this solution?

Thanks

> 
> Thanks,
> Jisheng

