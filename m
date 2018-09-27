Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD17C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5618215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K+rmwh/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5618215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeI0RZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:25:17 -0400
Received: from mail-he1eur02hn0242.outbound.protection.outlook.com ([104.47.5.242]:27911
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeI0RZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C09Ab3tvPLWRtI65kM2W/8rFsMPHqBxRa3UJncRNUQI=;
 b=K+rmwh/KmyF6poyRPBH/iQ6G2CuSROQlQT8vQfQbctK9OVR0U45hjG2tWHMtfncZdX9i/tjJMT3O8RQyQynlNra2T6rEBDBTq0ZI/pgQxAjxxA2x2CaQZu1JxWPgQjsDizqMz+e7I5ZNwv+JaH0QeN5TpcvWCwWVJHsQEix179c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR08MB3599.eurprd08.prod.outlook.com (2603:10a6:803:85::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 11:07:16 +0000
Date:   Thu, 27 Sep 2018 14:07:12 +0300
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
Subject: Re: [PATCH v6 7/7] KVM: x86: hyperv: implement PV IPI send hypercalls
Message-ID: <20180927110711.GE4186@rkaganb.sw.ru>
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
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-8-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926170259.29796-8-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0036.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::49) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a905f9ce-b68b-4842-6b05-08d624696376
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3599;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;3:dVFk5PJErwseJGSnVtzjds6c00Fp51QkqtYWh8AYJjzWXA97dEpqwYqKgNZ3Og4uXPCWUAZiqK6++6RLy8hQmbAWht/Ci9SGu5LKDTeieB+2ey5sh15rdV5CJNpsqDskXg2wd1OngilrrKJLsNPi4G6LA1+HVj8rDGRDlhroeQexX9pwOURTq5nvLgxbeg54G0hveL0IfVgcG33wSKSdQC+NL97vJSmPSugYMYafWN9qy2rI3kGtKNV0Vtnou2ni;25:Hu7anmr4QZiEJVw8/P1txD8ZamutY+4mpYiwJE44IXUfM+Ai09qCR47SXz68i7Ohc9MlKnyc3DUInCNZq7K6TUryfsdjizPeOxnXfNNURD0Aewvp8ale+AQWm+o2cf6jJpAuGTDyf+/c1qJfWFmWqH5BA7RH0LY9pOL92FAeTHNhj4C7cFw7QjAA2GchlsRG2VPqJGXo+VEg7VMBVt7RirHsGfNnnxREas5n09dsd22LvgULCLZknpF9mobNLgVsq79/gw6UDVxNc80+5Jf5A6UTb/jJyNhewqv7r0ngptAVdFmOcdjmwCalodaq9uXQnFooJfexAU05E/gnQsMhEw==;31:zXbYvD7FO19cddeFeezHDM/le9oUz7+sB7N86PmsgAeD42wmF11AvbnEYEK6KXOZGEjCfW/pyBy+ufgHmwg/V9jdnonzXSxFUxJHN7zoYVjmZsoz6gcxZHUs06USEQDnIOCU+hTNqZd6Fz2AUdths3HdT1Lfk2MdsstKofuO3K+LefpiW7y3JUH4aEbLHPXAPVMl85IiUOK90ME2tOexHMQtWanYsIP2wfdWHPaIlsY=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3599:|VI1PR08MB3599:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;20:w/Pxo7zkhnIPsWYYyc0jdkdpmysT3zBRcNMBwtmzOQl136waFzt52JOTGc5dujeVg96FSDiHhfIjdWwI0Qzx2FjblysQ/QUsx/zL3asWsW2BFmobgQsKF6lgdIk1Le9f6Aui6aNtF1NyZH/YF7eGRL1uxQh9pYYTq7u5ktTEfi2KsA6Ri4lIvovaEHBT0M4mmhrAUj59O6EvWx+lvahNApqVS1CM4fIrR/2VoGpyUYq8sEar073vrDo7m0RJDWCigY9rJjAkPBoHyTjSTHONgykTiDES1lWqMshj+q+SAc2GXLw7TlZJldwhTWCrjJTLNjA7kCkMg8Zx7EYScygGi15LO/PipEkaQNXos0B3+yw2CYDO6vDVHZJn9y+hD5Nbix/JSU7C276UcM2uY8X0ecOrCEs44hXIFTMIsfKMy0LlpH2m452MOGMAyToLCVOVhTtalLsOUve2FF0/wzztSk11L1sznfSuT1Dh0Asl+JJI+PovT+uMtUQTLHAeh0AC;4:d7qywLj1jAMEaXC6UhiqQoGQyG0jqPnSpAvnaSbWqWwQxJzL9cl39vKf62y2VR1Ww7SwEECes2RdhX7q4L7EI4/ipR0SuZ2v8iCagj6ma2QcVP4uyY6N6eQ2KGQrItqjPddVcYjWJOCk4ArrMVvbUFNeN23Y2ZJg1N3Zgg2ctSMgTtqUGKS8SIAk7I4Oht1ipgKAfS4K4hKgFaddohbXZ0KfDBiFqsjBFGeFC9U1N6dZIZlvu7R5XttbX3/XtrBzJJTl+ik+20Erk9c6pn9lGAGV7yax1QAhIs9j7OMcFdOJQ8qIftAj8MDpb3UQ19Uf
X-Microsoft-Antispam-PRVS: <VI1PR08MB35991B19513EEBC1B9B8297DC9140@VI1PR08MB3599.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR08MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3599;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39850400004)(136003)(199004)(189003)(6506007)(386003)(229853002)(97736004)(186003)(36756003)(23726003)(26005)(68736007)(1076002)(7736002)(54906003)(4326008)(476003)(25786009)(53416004)(11346002)(16526019)(446003)(305945005)(69596002)(58126008)(55016002)(33656002)(9686003)(3846002)(66066001)(956004)(106356001)(6116002)(39060400002)(105586002)(486006)(53936002)(16586007)(47776003)(6246003)(2906002)(14444005)(7696005)(52116002)(86362001)(76176011)(478600001)(8676002)(316002)(81166006)(81156014)(6916009)(50466002)(34290500001)(6666003)(8936002)(7416002)(5660300001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3599;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3599;23:oQO7HviIV29RFMp6JgBhuiO8DGEi22i/d3uE6uVda?=
 =?us-ascii?Q?SZXhj/gNhJj+LaozONWUsZquPxYGL/lDm1Ta8IEzc9Mh1mLDXMiRkannZYs5?=
 =?us-ascii?Q?xqgsneC083HMZzOhSk6kzaQHIg2j3yLR5O90/Y8OSMg3zxGCX5tFrQea1Fdw?=
 =?us-ascii?Q?cI6fqSIehAcTT0FcA7Tqu8JkkTfnzuIfh2ilEsNUv95ktXyTVyhOoIHTSJsP?=
 =?us-ascii?Q?chHIuGKwtEydPtyPpnvFceSKBDk3oVf3I897iINZZXJXoAAhMfami9v7uMA8?=
 =?us-ascii?Q?ZiQCMBDNU/EjU19vdmXQPGudeyc7fNRYqpR/KKN+rgawFLK/hpfFrBuyZ6+a?=
 =?us-ascii?Q?CSo8xyQx4KEMfhNacjhOOt1HTW6XSrXg5NKPBmOvcRhR+7hOPiii8mXf25XM?=
 =?us-ascii?Q?igPNJP+NOYxPs3MYVGlSh7GIHCzZ+OpAqolXSql5sWadim2CgYk4Q9zk/UgG?=
 =?us-ascii?Q?Lzj0lnDSfGb7ZFMr44AacYdXOBfMFEncHOmBjId2KQMpzU3J95c+X23L/5ro?=
 =?us-ascii?Q?1DKrQAw6Nm7Mxxr62vl9gdUzI/Dj/HaeGCUu1luorppk3GSoVL/5B6zrLPbe?=
 =?us-ascii?Q?rpw2DJ/mAjRArsOLt0p9v2Hyu6bDpigIr4CT49FVxd1P8QW5QjO2JM9cdZne?=
 =?us-ascii?Q?TOpvhuNkZOZzXdxHzv1ApcQNIiv5UccvYzAUFQkWFwY/4Cquxm/QgKAuP/dd?=
 =?us-ascii?Q?TUh9a6znoOa3vkFpGwk0qWA2PfgKaKDMXQp3mJB6kKa2OLW4B1HcFYcOt6Tm?=
 =?us-ascii?Q?UYGhbc327rPno3oIJ1dv8bgDz8udMui9O0cOzA5y241AoGeAfskEDvQ+Qhcq?=
 =?us-ascii?Q?eJ1tbgFROwD1MewxPeUcnip0ZEALXQN1RaZb0NdP9haKh6574gvgWwrkcHea?=
 =?us-ascii?Q?EqLhpeWbKTBW3PodmNcV5mhbuoTTgm2ZfYncReqyxi6+OtzFFmzICj0N1nEA?=
 =?us-ascii?Q?YkSXmNSjkSPiFHi9EtXdVkSOzlJ85CAJ8J8YQdeeFGyVYhJld0CTvAdBS/3Z?=
 =?us-ascii?Q?twxzu18FQFTEY/rUVTTPR0TB84vvVFW8Q0DueCnE2U1KXpYP/E3tEhigq7Sz?=
 =?us-ascii?Q?tsuJ/6bITCV33Pr5yBPRvo83O3iU7Qa018O5GEhcWNY/b7kyaeEiuQ9/Wdp2?=
 =?us-ascii?Q?9bcKiMUKSgqd/jfuqi+Vf1Z5RV8b0X6rrF6br0ish7BDoFxOwlU2LHi5bVza?=
 =?us-ascii?Q?e21yfvXfOiZv4ZwHwUyVTHxAKfag2ue5NHPSuTpORTnL1HI5uWUJff6tTBG2?=
 =?us-ascii?Q?D9LX2mSfn6gFmWh2AUANHTvjszw4EqKroEZQFys9OMo7Dhr95ZCUBqf6++qs?=
 =?us-ascii?Q?YX/3h/+D/LpL+DT1h2DdKT5z5gRXXQXhoNFRktclKCb6nMnCO8SkBQ5DIFlX?=
 =?us-ascii?Q?84tykoSdy07ZOg6+ZGFLELz9vjfmYX4BxhYXVG6SNT1xp9hoJsXL2XPoHg5s?=
 =?us-ascii?Q?svU/cVAEqSs9jbitHl8G01AGkCCICU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;23:BfO6iXULfKYV+4w15HsLMN9XnVSHpflVIpu2aiftRAumHr89bOTZblHqV3OR1QjJD3v5eYL4Lenu3AO7uKTlG+cxoHyorjNS/w5sQ2q4jEuhddQrkP8nEh94uZhS3v0Ct5E8NUdQ4MDI5v6k627qQg==;6:SnvQvu95NvSwc92Gxnz5lGz0Jn2tYm9TLSBGjoD8hRY3fL66vV2DM6GiuwxrQjM6rECZf4BTZyWgCMS8MxaCl7BvhaXuiW30zHEKNtya1p2GNrYScgJm8p2i3P8WE5VJVaT8qRWn6XLmJzH3cdWXjjnDdzHOtihfFBvXxFt8a1BJGu9X5XI1gru1kCkkuSaVmZMVHGaBBFew82p2cwXX41hXZ692OduNJVgF3Iy+ifp+2RJb5ij9RLgUKGRDUU4ALzvV/qnd1o9gESAtX7BIHNDFgTLl2JypDqC8JF7BsRs9PbdKRV8SOzJ3aqkXoJR3BojOi0hmJOpERwaTwV1dnS0p9WmZMw2pQ6tuMGcccDlJJ59hiQZElJkP7Ytsx6FGKiDHyyAdpyrJk5inkhOMK2itT5bC/4C5bGI8wH4ZgX65d+zYOU1art9SWhh55YVIjPP35EYbBFuqhkVtRsBqRg==;5:/RX1o8/+pjzmci7HBjpyWxct36K1teUOAJ/zgCOdyjr4SRB9U9ETdTtaIPJpOOnWEdZttc5MvQJyNgOs3Wqc6LsnFzxKt5EJxrD1FskBbw6EcTbjquUrJhN0dnYdK9hVpIsD2mJuz8M3w+VkU1trkS8IFm9Jqv6AZf4UyjXSWIY=
X-Microsoft-Antispam-Message-Info: Ub4bKTHU1paaC6FBKhWCqGw1V3TEyH0a8JpWGM3X9XT05bd4yBQcPv+mQJvUV4yJmnegxy+HDNMvRga+7WegJp1/JvguvHNGf30LRVDd5CQ9zg9PoSm743ekz5EHsFUHGwW6Jq4AJ3uSXoWI6yE2cZUYiZpRvgwIsa8VHCKvwiumQgYmGOgmQqGBcpcMN5BR5ap+oPtX/y3uXZib31BsHohH+i73T3VxSln0sDcOys1qcJxuRxUHIVX34MA1SolPB8FpL/3LwHnGB2N3AsXSBP10PxFjO8TLZJDnPw8SZNhJON2R7xQHXeOKnc5q38FuVz3BgHhPouLK2g38qw4T0DDkyEsLUDtimHZqimfDizG6gsHe4UG7YxflUIZLh1Oec4XcojU/p+P57UPvpyaBHnyP9zRHG+w1AjnnUFJT/X5U+xKRBeu4blqt915pjEWaoT5wXUpCEFa9Nq81cM6WhLDwXHMexuq351pbO0Mwp2TvzQqfJ2BVaERdECyJVa+syja8vpet1A2oQE5I5bDF3KfsL4NFcmdEnbseS66ajv5gyid6JcNsQO2yVUuXDJdquipjbCzg0yLYJs6AIkB0mQ==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;7:bcx5eC1Lgn6D49VtqEiE3yP2SwPAwsfgA4TDJLoaNtyV8s039SDd9mErsKrMsuxTl41cTGKvts/7wjoaVCn5a0yBDSBMyNG79a2VCrumanRNJ87L0GPF4MI0O+HgZXxxYHBtvp38RKDa8NwQN1VbN3XWUrSjCIFfDWOQD2XLs9rwrr04yS7TGwX/3yeP6T2y9XIQ926oaE0IzuuFQD2cAocU5zdAkfgMpsSDx0cnpiaqc+8z+18e4izOXSsdFfkm;20:WlWCRM1rH0lMZ30BJQ5Qgq9IGDkLCwaX1NoCNRRxN47JI99CMtfTop7JmnkVJdJmkWzqRTiDBagaMqLGs8UiS7IKwbTWQOjE6VOmULZbyREyVtQZh8ZeYOOK8Ztd2UWbsG65mIAvZdtfPpk+ZeUtw8hdUGLhKlsIPWfPAQuYc0M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 11:07:16.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a905f9ce-b68b-4842-6b05-08d624696376
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:02:59PM +0200, Vitaly Kuznetsov wrote:
> Using hypercall for sending IPIs is faster because this allows to specify
> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
> will take only one VMEXIT.
> 
> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> hypercall can't be 'fast' (passing parameters through registers) but
> apparently this is not true, Windows always uses it as 'fast' so we need
> to support that.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt |   7 ++
>  arch/x86/kvm/hyperv.c             | 115 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/trace.h              |  42 +++++++++++
>  arch/x86/kvm/x86.c                |   1 +
>  include/uapi/linux/kvm.h          |   1 +
>  5 files changed, 166 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 647f94128a85..1659b75d577d 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4772,3 +4772,10 @@ CPU when the exception is taken. If this virtual SError is taken to EL1 using
>  AArch64, this value will be reported in the ISS field of ESR_ELx.
>  
>  See KVM_CAP_VCPU_EVENTS for more details.
> +8.20 KVM_CAP_HYPERV_SEND_IPI
> +
> +Architectures: x86
> +
> +This capability indicates that KVM supports paravirtualized Hyper-V IPI send
> +hypercalls:
> +HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index cc0535a078f7..4b4a6d015ade 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1405,6 +1405,107 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>  }
>  
> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
> +			   bool ex, bool fast)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct kvm_hv *hv = &kvm->arch.hyperv;
> +	struct hv_send_ipi_ex send_ipi_ex;
> +	struct hv_send_ipi send_ipi;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long valid_bank_mask;
> +	u64 sparse_banks[64];
> +	int sparse_banks_len, bank, i, sbank;
> +	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
> +	bool all_cpus;
> +
> +	if (!ex) {
> +		if (!fast) {
> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
> +						    sizeof(send_ipi))))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = send_ipi.cpu_mask;
> +			irq.vector = send_ipi.vector;
> +		} else {
> +			/* 'reserved' part of hv_send_ipi should be 0 */
> +			if (unlikely(ingpa >> 32 != 0))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = outgpa;
> +			irq.vector = (u32)ingpa;
> +		}
> +		all_cpus = false;
> +		valid_bank_mask = BIT_ULL(0);
> +
> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
> +	} else {
> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
> +					    sizeof(send_ipi_ex))))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
> +					 send_ipi_ex.vp_set.format,
> +					 send_ipi_ex.vp_set.valid_bank_mask);
> +
> +		irq.vector = send_ipi_ex.vector;
> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
> +			sizeof(sparse_banks[0]);
> +
> +		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
> +
> +		if (!sparse_banks_len)
> +			goto ret_success;
> +
> +		if (!all_cpus &&
> +		    kvm_read_guest(kvm,
> +				   ingpa + offsetof(struct hv_send_ipi_ex,
> +						    vp_set.bank_contents),
> +				   sparse_banks,
> +				   sparse_banks_len))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +	}
> +
> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	if (all_cpus || atomic_read(&hv->num_mismatched_vp_indexes)) {
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			if (all_cpus || hv_vcpu_in_sparse_set(
> +				    &vcpu->arch.hyperv, sparse_banks,
> +				    valid_bank_mask)) {
> +				/* We fail only when APIC is disabled */
> +				kvm_apic_set_irq(vcpu, &irq, NULL);
> +			}
> +		}
> +		goto ret_success;
> +	}
> +
> +	/*
> +	 * num_mismatched_vp_indexes is zero so every vcpu has
> +	 * vp_index == vcpu_idx.
> +	 */
> +	sbank = 0;
> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64) {
> +		for_each_set_bit(i, (unsigned long *)&sparse_banks[sbank], 64) {
> +			u32 vp_index = bank * 64 + i;
> +			struct kvm_vcpu *vcpu =
> +				get_vcpu_by_vpidx(kvm, vp_index);
> +
> +			/* Unknown vCPU specified */
> +			if (!vcpu)
> +				continue;
> +
> +			/* We fail only when APIC is disabled */
> +			kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
> +		sbank++;
> +	}
> +
> +ret_success:
> +	return HV_STATUS_SUCCESS;
> +}
> +

I must say that now it looks even more tempting to follow the same
pattern as your kvm_hv_flush_tlb: define a function that would call
kvm_apic_set_irq() on all vcpus in a mask (optimizing the all-set case
with a NULL mask), and make kvm_hv_send_ipi perform the same hv_vp_set
-> vcpu_mask transformation followed by calling into that function.

Roman.
