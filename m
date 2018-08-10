Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C60C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DFC223B8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GB7mbP3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DFC223B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeHJFLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:11:41 -0400
Received: from mail-eopbgr730046.outbound.protection.outlook.com ([40.107.73.46]:4928
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbeHJFLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjWeN65MFSPaO/D6F1cO2cmt2Ef58ky0/xI758ZqrNA=;
 b=GB7mbP3+gQ90xJmXjBWcDM+eravQFGkApbOHEe6M65Q3vkcGNFH9vFqDiIBldtj5LtPPdXGcTUAWipdhdodwkocswowSUK40sMyC9Wgd1V6nXlejzXkE8srk9AobSimBTLdkqtf8/Dx7+CjlaxupTMITzFE9WmxubFIeZ2khXU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Fri, 10 Aug
 2018 02:43:48 +0000
Date:   Fri, 10 Aug 2018 10:40:55 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomas Hlavacek <tomas.hlavacek@nic.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: mvneta: use the correct napi pointer
Message-ID: <20180810104055.0f009ed0@xhacker.debian>
In-Reply-To: <20180809121308.GC16359@lunn.ch>
References: <20180809200242.1166f86c@xhacker.debian>
        <20180809121308.GC16359@lunn.ch>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0179.jpnprd01.prod.outlook.com (2603:1096:402::31)
 To BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f642414a-18d8-4f89-882e-08d5fe6b1ae9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:cmMLqJ4t1uI6jjZ4r0bTG3hKMshE8KKTQAmydJ5pQ81r7bROCnUle//qWgb8GCYea/LumMbIltQHvpfmg0BJTir35yzrWVt/Z1P+AR7dC3RNcIpdc7/vY2g1SN1t/m0+GXMvKkyAxehNv/TrvcBIN6QPwzsMYcA1F7y3oxybw2Z662gJGcWk8sUtoUwXIc083JxezaW85UfbAUxnRaVSEHKdg/gmiqMccZQUlhfQwaWIP6zf4bzob1pzHiurwTUo;25:FikTOIGS/V7T+bUZrctoEhz9JrvrXB51Ucw0tjaM0aBMvJ5fwhljO3M8k2+7usze3utO/74KXskDglm4iEkchOV4YQixQ1x9h3Eu0G98+qVlVH6jeTfi/f4mSh5Pqf1e8PQhhFwVDG4n6uKPHBzhkDyVM+VNwCjp1WLCbqjcOcUzqLqDzuain68S0p3CBaUzuKikdv2mEeNmyrb2qygvfreCHUN+3qKTgyGol8Q/eDC0ZxLc6DBblPVcnzlsdNq92c05j/T83Jo3brjt7zXyq/M10IojXhHzd1jz11Rxh4IPqNwH33z9E6OyjDnGeU1AG1XLKxXh08NPaP67mS2qIw==;31:j3PiP+kRyhkaWWNxiW8lhhTf/wGBg2HAK4H5p/2h6GAxTcOLqQ2vJn4kUAClG1YkX71EsJsAx8EPhXh6YKKArNNwgzsVfnkC7ehWuwhFqKvKfvG9ZJJf7nlN77dWgFfRD5lTXSCFxnD7WWGcT2iZ5el4/BbYJJpDAh51r4OW/ggDKljXDWEHHDI0ilS/orT4R+BaGdAmpkui0bLSP6fBgZNYOgMfxHAgOm+J759wlC4=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:56v9CSmWkylKuhhKVnsFxT3zcuQy6O9tNETwkaoO4WrObn7iX3w2YogF744jI13Psy3JOKXLNtjM8xl2IasFnahwDaVTlFGdgZDe9KO8oogQrI8biASpu07/20/yT0o0lSpr7VTNOkYQISDBI7wEt5vj+WpPujLW6YbUCaIwy+xJDRqNzi4pUjk2KaTrwUfJOJkZw9t/CQT75BnUdV5+6vemZ+27ahLqU46QrkB1iiO/CDUBDR+ZawrVKEnzu/7Mu3uEn5wGJyI3y+umx9ce41GAzdtQ//bOvuZqmoz4tyUrCCp7FuNNcy/h7BMM44KkPiyFJNppLxBtSjeta81Ym0LDThqKboUw6xaxaNZSzvuY028nIoPHa/ss//bGs68V8CbU2esFbdI3/41NrOO97li0ZDQZqquaFxgoaUlq8jkZU3wj3dlNdlkfgQzJEXXbHkKXSAHL3T5cqyNMoMsXGjWQfP7nQCbpyRVuibOmYoClpZDIf4I8IVRS/TTrMZPs;4:X+N4WQlRT3wBzqiTMAC+Da6ujKpBKflBU/jamaCvBUIGRifyvikAgPbd7SmBpxDCeQyJgNFW4j4Zs7pugUFTzPsDFiSFF3X6ljpRuw62jyW3TncDVvSRiFTGzplPeULWAjBNAC2XccmmUm/+lX7FeYnwJPY6edgohRYlA3X/dTqRJlqvS73w/V1lM8bDdsiNeGewOiJ09QB5Ul0DOhfkDxA1sOccngzd4OqmRCc2ulP86Q8Fsf5Q6Mt7ffV4KLCKHAVeZG9uXG3DfUX5D4IEgA==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1571E3941EAD09F61C0CB2BEED240@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(230700001)(478600001)(6506007)(386003)(106356001)(105586002)(97736004)(476003)(956004)(50226002)(16526019)(486006)(26005)(54906003)(8936002)(186003)(76176011)(6916009)(5660300001)(316002)(33896004)(7696005)(52116002)(446003)(11346002)(72206003)(6666003)(4326008)(55016002)(229853002)(6246003)(68736007)(9686003)(86362001)(53936002)(2906002)(7736002)(305945005)(25786009)(50466002)(3846002)(81166006)(6116002)(1076002)(23726003)(66066001)(8676002)(47776003)(81156014)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:Vn+AXRlbSNFgieHBzof9NV2bG/i9hMppwLsV9ip?=
 =?us-ascii?Q?7BygCa3Wp9fic4KbXIuFdCBo/p7gkNmzJj1hl8UEzKb+Ckj6FaLWJgN3bZUt?=
 =?us-ascii?Q?NXsKAFjWzXFVd2EWutmIQLr9MFkBz38Vl4p0iP6E7CxCJC6YjTmMvVE9Pdgo?=
 =?us-ascii?Q?Abv9dZtt223tsHrA+vX4pSSox3iB9GIz3TFOWhD3uS5F2oQt9wda68qiaybA?=
 =?us-ascii?Q?yNBlQ1SKCC7u7vZdPOaPJ9XnLDgtdjRayitHFahMDdlvj0pdo61rYXd4EXHM?=
 =?us-ascii?Q?vNL1MjHC9bovmxmuQOj4+hu7g2hBtXvgPJEYoG32051fstqzFZjEBNg3/OC+?=
 =?us-ascii?Q?1qVvePfWHcdL7T6TrcoscxLrZx9k6EBImynZVI1KWgabKolCI25GuQCnxwT6?=
 =?us-ascii?Q?1XrK8NScmuWQaQuqlIMDvmV1w0JoLFRgOIRI9hKB/uiRH0BEK8XfWYms2xlw?=
 =?us-ascii?Q?7EW6pFjuk+MCn6urcfShssbY2O/3WYbzy0/1lNYp0PlJ758NdFyj7GMt29pp?=
 =?us-ascii?Q?d1KLwgZYDbPTDPPx6RDBfj1FWaVaTN9gR5giCKQMFRDCgI7qn+ESInSScApQ?=
 =?us-ascii?Q?p6LpKJQz7yGsJcbah+oOpHf486AlsCScXIswOkY31OK6q4rXBK4y4Sp93tR9?=
 =?us-ascii?Q?RJepCkDx6cB3AMMF5LlYkxf3plCd29F2YtCniKrsa8hU7qQ3EcXGPdSMeSv+?=
 =?us-ascii?Q?7cakC1kI9U5fAFTUg+Khz3wZcijZIghzlmuB2a80smcZQIrJrhcpdBInTkeg?=
 =?us-ascii?Q?9k9befvtg2gHRrVydwaB/eMqbmzuynDz2lEmQa4fyo7LFoBxEXtBBRPWZgIE?=
 =?us-ascii?Q?dUMa2IVNwIhrJc70mcIF7Ti4GKAXJJb08BLYzfJgbBhfyyHyZ25O/3m7bSaz?=
 =?us-ascii?Q?doOBgiJ87kR446dyiw0qORB/GdnkIRzLqksH5owsI7vJIDchoM6X8VbJm5cA?=
 =?us-ascii?Q?Xs+scIuL/F/iBI0HJCh2OV2reR1Wz16Fg9hXOrvDBZCKNQmQsFRmC0FEnnqt?=
 =?us-ascii?Q?aX9tAyvCXiIuCvQvkbJfl1YXqi16Tci1xuXYumvaPj18xWnS2IeLqtsf8V5r?=
 =?us-ascii?Q?wByzdszWLKSpRE1qhjrP5ZSOks4/UJAI4WLY3ye+Hk+GW7hvKl9UTHVoaeLi?=
 =?us-ascii?Q?gRgZsDBgmsNMRXCtEvGcgfxt1dEG3L8k20KbqLX9E2qBawujTDUD3WapW2zl?=
 =?us-ascii?Q?luXzZ+ytsaUg/lZPkTYrbLqqJNLXi2/vQps2tLsXeBJTweuW99scs5+QhlT+?=
 =?us-ascii?Q?N+OmiZ1QcFGGKifp5JVlXt1n7RjMOuj9sG83QlXo3?=
X-Microsoft-Antispam-Message-Info: s8PH4ekclG1cAtVMwqyATjVXINzD6qHL5RcZEhXAC6niwXgd2ib5sovBJNoVaPempz7gkw7hfGeXVCysc84Q6qi7B/8bMlNtFRlHC8RjXTg67uHtSCbsYyioObFg5hVdhrPxZUnB7E9AJJA7Co+i6A10tY8iNRf+jsQ+VkNRctYMNfXTcQkckpcEtdkgH8KeojUKw4tbyzqxqXo6KlsdCS7jI7Sog33Gq2LBCPt//vaapVMBGSoUlEdipObY0Aj6mDvhYEJsbczks50mQEZPPdpBRFxVsrFI1ZQOqKTnZ/DtBdudvtk/tghyJ2I7TEj79SPa54O8TrkD8VnrH8srrZTd8h0NVtRw5KTEq06dk/8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:fox3hpTKSxGavMDW+h7PQHhqvRmh5SREwCir0TbMiBp4/bi9t81hk7tI8bAoGkPgzS9HPKxI4OFxs5NFl5CWmQk16keP3ocfHV4jgKP3YOYB3eGZ8nO3SUWLkZO1HMW6+jU1hY23GLodMeUClHE7e4z9GHhu6QcZGqkaFe1zZtV9Rmv0E4YNTAvac/RZR93yC3u6k9+Nt+LPh+diytTuDlFFfftMYraTKuadL+Knuk3tOvyO//d1XwwaIg90WIH0NrFAT5Rrc3bIIkC8PF7Lw6I1w1nwUci2mAnhBpoYDwr1/QYcDQtUdPErclKH9pt5KdTsZxOqwFgiMqViCetjRMBufbGesTsdtPEx78G/9OL7bSaau3cGYH9/y5g3xAOAPK/J9gBjuEHH9Z+c6Zz/fgNeX2tkBBIidH1rZOPE5GsEK/B7Fq5LPRgc8LiL/zFBqBU40IEZbrv9UaN4wFAJDg==;5:mPjAKn2OXfFMk40raj+mxK7aCOp1pJM1027KvKYZmRXEUpkJrs62F61eAxyvF5yw61DNjd7YHbfCV6LZjasIDhH+MmuLrSp62+QvrSNB9BXryDUdaGo7+0m98vFFHlXPOIaHbHUd2olVTC+6shTo46vNVN2pQ8sIxpf2RcihJ8E=;7:IoYpiJQaBbln5PnLpMvzGvJS6ywVLjUgudECMHmvUmaASwRgGBmCc58D7t/c9fLmHXjoZdujlRHSCAqogi0RQOlPbbW3Ql2Tk1VXDjJRoqFz5O4pt7+a/CXMW4oFnnX3UpTwtz3GQeb28P/X25KSBnczgOA3fH8FN8njdpfJv2EFZO/WSk+8WRHuAXDrOTmrkzp2DuJfpAyO/KJzjtfIvzFwQS6a/JbeXAbn0nUxR0v63BnikK/8WFqXKJKDCTm/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 02:43:48.4259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f642414a-18d8-4f89-882e-08d5fe6b1ae9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Aug 2018 14:13:08 +0200 Andrew Lunn wrote:

> On Thu, Aug 09, 2018 at 08:02:42PM +0800, Jisheng Zhang wrote:
> > if neta_armada3700 is true, the mvneta_pcpu_port's napi is invalid, we
> > should use pp->napi instead. Fix mvneta_config_rss() with this method.
> > Although we can fix mvneta_rx_hwbm() and mvneta_rx_swbm() in the same
> > manner, the napi parm of mvneta_poll() is always correct, so we can
> > pass the correct napi param to mvneta_rx_hwbm() and mvneta_rx_swbm()
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> 
> Hi Jisheng
> 
> How does this differ from

oops, I didn't monitor the net-next tree recently, glad to see it's fixed.
But the mvneta_config_rss() also need the fix. Since your patch is already
merged, so I will submit one separate patch to fix mvneta_config_rss().

Thanks a lot,
Jisheng

> 
> commit 7a86f05faf112463cfbbdfd222012e247de461a1
> Author: Andrew Lunn <andrew@lunn.ch>
> Date:   Wed Jul 18 18:10:50 2018 +0200
> 
>     net: ethernet: mvneta: Fix napi structure mixup on armada 3700
>     
>     The mvneta Ethernet driver is used on a few different Marvell SoCs.
>     Some SoCs have per cpu interrupts for Ethernet events. Some SoCs have
>     a single interrupt, independent of the CPU. The driver handles this by
>     having a per CPU napi structure when there are per CPU interrupts, and
>     a global napi structure when there is a single interrupt.
>     
>     When the napi core calls mvneta_poll(), it passes the napi
>     instance. This was not being propagated through the call chain, and
>     instead the per-cpu napi instance was passed to napi_gro_receive()
>     call. This breaks when there is a single global napi instance.
>     
>     Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>     Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
>     Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> which is already in net-next, and i hope net?
> 
>       Andrew

