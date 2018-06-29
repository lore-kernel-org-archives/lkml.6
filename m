Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C46127F12
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bIZTr0nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C46127F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936397AbeF2Mwh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:52:37 -0400
Received: from mail-am5eur03hn0204.outbound.protection.outlook.com ([104.47.8.204]:51456
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936372AbeF2Mwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtsav3SqMkp5fX9ys+J3A6CCXUiCNl4fB77+5sAbMWk=;
 b=bIZTr0ntJOUttT/n+89gm2jjp1tOtFJu/djMedfUpwzWZPfI0wpudMQefHuY5VMVX3aMQ7c+TkMUDK5V9oxXS9c1LR9xKhTWuYzHE+N+yZrZYSKu9wpqfTKeX4YN2fcX/OeU4WIvsONE+4yeHy2VNVOsZnhAj62jEd2QPpsZZvs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR0801MB1983.eurprd08.prod.outlook.com (2603:10a6:800:8a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Fri, 29 Jun
 2018 12:52:21 +0000
Date:   Fri, 29 Jun 2018 15:52:16 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx
 mapping
Message-ID: <20180629125216.GC15656@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180628135313.17468-1-vkuznets@redhat.com>
 <20180628135313.17468-3-vkuznets@redhat.com>
 <20180629101134.GA15656@rkaganb.sw.ru>
 <87y3exdh2o.fsf@vitty.brq.redhat.com>
 <20180629111227.GB15656@rkaganb.sw.ru>
 <87tvplddrr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvplddrr.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0106.eurprd02.prod.outlook.com
 (2603:10a6:7:29::35) To VI1PR0801MB1983.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1168e804-2084-46ce-e118-08d5ddbf288d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1983;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;3:giS3HNVT8fEp50ltsZjXRSUH20nK517ESrqThKbfPKi5+OiT7xs1gYH6JnslyO9HM3nUnYy9yroV2uje3tsInGG/HfabPkxi5oMiVqGyK7GnOhAOru2zefkfEHrwOHXQAmDv/7QbVytoOuBktdJBh1zEmnbiCXK4IoXBaUZvEpdGkUnEug66zhO+P5jN1zAzaslrp/46poHPVNQNw3KK1AO4j+0T2CUn4JzJg2XXRBkg7fIaFMZFFsTY1ml6Vpl3;25:cXbQM4i29HS1Epyth5maJ8dgt2rnFHG1x3vDF1/wFCILnNQ55qD8TbLdmFpIoxFMa333p7JGC5EY2Vs64NnHSJYHDmsyeC/MUjrcOpol3RM7zCs0jbBjGsf8GrGp4h80eQMWVP3jjQy9FqFL35/VK+Fmkq5kx3MshSbLondOLrWxzRYlM7TtcY3CFtNXhpfDLg6sUhMl1Z7KAbFV7Uf93ts+38IrxD2KsmMO2FTOMab1x5RaqIL1Sekm8Qz8YMTr5V1DcGXyImxr10fU4TBVJ7ikqkpamftlWCxt1P7fRzVxPxrc/n4D1s7i4Goc3ltiAT0w8ZTyxDba/YQ91JWshA==;31:Tbu09OwALVcLKURm8PCFDZ2GH1nGoS6KpyWRul+z9ItcZssWJkFULcXGcxU8sM7zC2pW+YHkMpHeiOMvc6BF/lw+LpowDXhUyhxhUeZEtBDnGt0XvZkA3hqUDmoe1QCFDGIqK1nRNvy9TvS+du9P7lCWwsYyLDzUzG20qfdG5x/Z+ewuIEAU23619JNzQHXOO86SRfCKAR5qCqRJaCdLcr6e5HePiSMxyOg3Nt06dS8=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1983:|VI1PR0801MB1983:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;20:uYVqoG8F8zSLT1pkKFsJq/C73JolDaiXtE7smFKM5MwY87axpYPCe6AFSsfnn6m/A9Lv7f/Vscbg6ziSi99zCnD4cW2ufbvVTd7LqprRHcGaQClrAmtyEC0BKyPvKiE2i4JJlUZHLgiroC4cwy0s05zbtRdWwTQRBc2gWPgDq9XUC+LVxzXXqE7G23M737cjE+LwdE67RIcqV17yAhojesZgq2Lp1OWGNpki0qZz/yztp+2lF2OrshYSGolgRzfB71hZXs0BHm4ml0992N2vlmF9t8rhRbUWqpID4F9UGDQi6Nue0DGvL9SQ7ROAugDRPltvyMQsfKBBOZ1sF0N+c1QR2re80aS6DnxKfjLemEDCnL8soSyB0CtRFzX5wLbKi11xI9u+5fHrpsS0JvpchYOyqXvkq9Ug7dPCgUdLiAJlhEhL3dXSngS3UbjKQJbJj+/kWo+eLzAzqa1eomQvzW2usA9vaMr2qlbwqWXiKK3r57HMHirMXp1Wr2juYzLh;4:1rVjXTn617JOd7sJGjnL4ZulXF04unx9j9K4VR7LIfkJ+2a7m8CKavu+M8V33Hp3a6Ht6oRAWlAesMyxIxWkat3lNH1byH3ZceXicB4P85Og5VxLPLI7Xl56vZhC2WDvBaNmiwyJrc26jBYkQyF7ysDE6d3pqqr+YNJkeeNvRCCZv+DD0htVQBreUj6Fi0P2Q4xb5Odakb4CRZdu2Q/rjxwOh4v9HsjAqaVTPqwBTjSGySSvvSB+neFZvozTRCiEE5UudzTlHE3UsU2R1w0xVQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB19835CCE89F3D6BC874DDB75C94E0@VI1PR0801MB1983.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1983;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1983;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(39850400004)(136003)(396003)(366004)(346002)(199004)(189003)(69596002)(66066001)(86362001)(105586002)(47776003)(53416004)(2906002)(8936002)(33656002)(76176011)(23726003)(7416002)(6116002)(1076002)(3846002)(6666003)(478600001)(6916009)(97736004)(52116002)(106356001)(5660300001)(68736007)(7696005)(6246003)(53936002)(186003)(316002)(16586007)(26005)(39060400002)(4326008)(7736002)(25786009)(58126008)(54906003)(93886005)(9686003)(16526019)(956004)(386003)(6506007)(36756003)(81166006)(81156014)(55016002)(486006)(8676002)(11346002)(50466002)(229853002)(14444005)(446003)(305945005)(476003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1983;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1983;23:PAFCYVoLSVadNcMSI/zgcF6G+Rv2hHMrfq4xv0N?=
 =?us-ascii?Q?oD6VoE6/CkkzmihWaEwncXnHKTsybxtDdMsxU+lO1VYg6xZRTC/RHwu9l2T9?=
 =?us-ascii?Q?EKaFsbk8K75JDdOjjWypFj03uD6z9UPENrbo9D7ubY4yopBsw0swpzzk4p4l?=
 =?us-ascii?Q?6hrWy+arYJP0fvPmNWqnNZXuOGquGr8d4PiMsKu4XKNjx3YssveBha90vZbl?=
 =?us-ascii?Q?tluYVw6+XEKiblj0keYhkxfGnY0fwQ7C9uPMxJJaeTru1KX9AUDFRq+znjVF?=
 =?us-ascii?Q?Q1ipDvTnZs+CP27EdCxmANQxcMp2R8m+UTk060I+HlpLzyOTpxD+5tHq+LPU?=
 =?us-ascii?Q?vriE8KuIWTfwnq9ag8tGWkIlG7b0mjx4OkTJ7L9nJHAlUbphOpMGlBgULc+T?=
 =?us-ascii?Q?GOz1DU4WYg+Q85ZvN5bsYgmStMfeYjar0axLMYLaqM08sroK8d6lJ/myurk/?=
 =?us-ascii?Q?b/mR/B1z4L+MbJu4Feru2rMDnTPvQ3fbcyAGrhbduP7IOUR7hYlXiHQ9bT+O?=
 =?us-ascii?Q?aF+IHjPZ3lKO7WZaFZmdnA/3Bwt88ahGBIvXH9VZdGtro0MWGlv6gWmeFBgA?=
 =?us-ascii?Q?mZ32JSBr6Z+lv3LSF4N49AVM9OyYq94Pya4Tb41Xw27ycsmbiEddVM2vQXeU?=
 =?us-ascii?Q?3oqjAfTeguk3zKK9b9VLuRvbv0k1XEw7oFMSDwaYZ4KDSTS0hmnbmCkNP3g6?=
 =?us-ascii?Q?uY8aL76hcsyxeCS3U3wOhJAab9fvs3lIApMbVdekuNaA5kbQY9zKIritCNQC?=
 =?us-ascii?Q?PbFk+gVvuI4Z4mI758s5uJWwt7OvY0j18Qa61GG8BGqRjHiWwRGXIWfU+nIy?=
 =?us-ascii?Q?sbucm77x8fr58S/WYoiwbJHeyBsfg6T2Q4DqeyoWSlttXqClqcL3uhEdUMGY?=
 =?us-ascii?Q?XQ/4CPC+wkTOptOx4FD5de1OqZu4zA+EAzs1Pm/Tweb6C9mmqQPvDCAPg9a5?=
 =?us-ascii?Q?uLMt/M73XWYCrCESlOo25CO3TDtkqYk6r2ZO5LuiidUsMchrA1UIfFYUGAUV?=
 =?us-ascii?Q?3+iLiesrWXwZaHfl28Q16V3CnANObWn0SBnM4KWCOiq1R2AK6xXqzeXVajH1?=
 =?us-ascii?Q?rQYhnjBzYvgPy/1fDRs/3hrralHTpmd8W7wTb+/VNHEM/mkD3kg7+6uifSg1?=
 =?us-ascii?Q?9UPJHh4LEx3IG7cD0TL6bTBAAEHujGnfqhtDyhyoqUjoPmtyZpZwkqKl/MIh?=
 =?us-ascii?Q?2++CKW+rtNhVX+Ch1NrcVJDkGK2hLgmcq4kszDh9rydiQ7a9S4g6jdjv9eTD?=
 =?us-ascii?Q?aKUp3KroK+a5GVWBtAaUxTi79i2nT2yytI/+0YI3u3OZkOEMW32TeI1A5bZT?=
 =?us-ascii?Q?sFWZM6YVH8t+MTcse9WPjkDv+/rTeIIqjRCPFn976pH1G+IGtloHH2D61sy+?=
 =?us-ascii?Q?jMAJFvUvlVC3QXSlRl6h3GGDs7gY//lojkq/hnChIacD9JGW7ZiFhYaItrle?=
 =?us-ascii?Q?BiW1tmorgZVIXUZQHSmfjaY2ODBxRanE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;23:O4LmZQ90m5m3YRIh7pkj/dPx7XD67f111WRtsxH0q7oJ7Y5UnQhkAuEQ9LS20RGBHh9FYaXm9D+rtXofzCBjqP6NAYCL/+CH/0HRiCRoy+KDWtgjG6FJTbGacLE5kzCZaFjfkhtCje6hh170HFWPFw==;6:/4f9SaKxw2v1VMTDWm1GW9pZxM614ioRalhwGSZA85AI0BYCUJ542tRphRRkBMhjnmDVbWgNCkj7eOBMgp7DXK4rPXQ1QVZ/7GEd9WLRW4jFtog+9Cl1enItzQEoyX3MxzPWvkp5WxesolfyfTeqpv20cxoYxCtTOTgjCvlOjtFnSnmHI8ZLITBEwvvwDVygrxGqAMFQcIwDj+h477pTXgbaxDlqjK6Tqj/d6kliLxSH/4ig6ygWqatVA5gCvJKAP+O27WSIbK7DUeiXbzzyENXFa9uKh3uYl31ngDersarNM37Jfbquo+a3RZBlgkPsRx2KhHQtvld78tp01pmYqhP7jV+d2V9HFyE5RUEA9MLCFoe0x+GaygOz12DC/GsBRCxvgVSyX49c9kNJKrPltBWTFl+1bLXk2ko8QSY8hVDsgSuqeOqtNmlJrYWqQDzG5D3GzmTUX9/42HGoCHmDEw==;5:Irk4SDfxOoLf6WU5H1Z0uayjty5bL1+n/HkT4v2WyjUsj7LSFomUoRYDYYaGL1EsAYUeHr8LJUIv7FZo55EmQyR2kQhqaVlwLW9IVQb0USAqYi8ftrrbc/wEV4ECTvoaFQBVLMX0EAmL7BrAGi9c3KfADUXIw/MuZEoRX5Ga42E=
X-Microsoft-Antispam-Message-Info: PWeo3rdTZWqB/sFk3n1LTuObjp9qOOEWjx5hG4H5qbu5Q7+w88LwLaKQtLQZqnQ4x/T2A5gRFqJB9tq2rRyl8gMVYjiaswcJIBiEk//IJOmqv/s0qiGKteebvW9yh6mKS6jZE7RgYjXcLjRfpz2JCZNexQViGGiQ7ETHVTIHF5QDqtrFX/ph6COPXSS+UW0EKJgM186qf1Op8lQXEbFZ+Q7XYP0DETgr1IHqSEZiypfBHA3QxDphaXAT/9wwBSf3XOgDETl6LGtwDs7ro68E/g4SC+4sXf/UZaS8wuskDF+oS9xf/qrnhOBl7usJGKgqCogoYZIDRFlrRJB+FSabpI7ZouqNPeDqluJA7WCMMzZJvqqvN5RCePsCxYFAQaIJKVNwax2Otys+GW2caaVBI+VWSCjHvARdIvfYz0aVAmMSofB4r5aNDZ28vGU+0ApUqSxrY9LZbOP+/DYnLGZG1SZEeHJptCPKhIVz693Zxi7+aSRSptyblclvO8qQjYac4qr7COco3zJXQCS7W49reVMiPLTtaYWzr2Pkz9+wBgCaWgDeqJ9dlMvTEct5+swoRl0ZOmJfbjj2oxxljTzaAQ==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;7:1wxa7sVu5qKLqoZ562+eRIzwx/gGoo/BT/mxC3cSvqZWL3mC6FamQQ/CVoOweoWJ1bafML2yBan/eemQ4F6eqkcvnHW+kLx3kFuIMyPBn5pfSe3lM1APm8y7OLFBBL8Q1B1bvBINl/fVaEUJ5Ta81cJj/prLRe5peY1DzfmHdcziDd6aFQoDcyzRkvGbl2CZwhDxtX2Je7oaddNO6g4T92o83g0p/ua/lh/0fzA7AUrN9mcTUIENozLHhatYhHOc;20:NYKB9xsjDHs9cTvodHlc3xvHrLw/LIhV66mNV6NZJ3f7RRf+a1Qc6J+vtKdQ08n3fFpcMcqe+Eg+VnctL7Tll6wwrXy1rhT/fO+9zDppSZ01HVrJOBOACoKtVsVs/Y2xcrF5uS0kSJGDEJ/ZBKYlN3OuYGfeWHBt3EOo+EBOEYg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 12:52:21.7921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1168e804-2084-46ce-e118-08d5ddbf288d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:37:44PM +0200, Vitaly Kuznetsov wrote:
> The problem we're trying to solve here is: with PV TLB flush and IPI we
> need to walk through the supplied list of VP_INDEXes and get VCPU
> ids. Usually they match. But in case they don't [...]

Why wouldn't they *in practice*?  Only if the userspace wanted to be
funny and assigned VP_INDEXes randomly?  I'm not sure we need to
optimize for this case.

Note that the userspace can actually do nasty things with these
VP_INDEXes, like, say, have them non-unique.  We need to be resilent to
it, but don't need to optimize for it.

I think I'd rather have a warning in kvm_hv_set_msr if the VP_INDEX
being assigned is not equal to the vcpu index, and start worrying about
optimization only if this warning starts being triggered by real
hypervisor applications.

Anyway I don't see an urgent need to bloat this patchset with optimizing
this translation; it can be done separately, if needed.

Roman.
