Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51DE27DB0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cKPzWjaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DE27DB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935804AbeF2LMs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:12:48 -0400
Received: from mail-db5eur03hn0223.outbound.protection.outlook.com ([104.47.10.223]:43136
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935467AbeF2LMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgBeYYIEUdtIhbLObOfqNhjkEhsVLnZQMGkX5vtOgRQ=;
 b=cKPzWjaEFE4r/pcgvsFmCxfbfDxaZX2qPWC1VSyZPEE/uJ08lw/1gUH0dFHRfJSEhzFmQAr1CwHsj5TIyLDMIqUmIcz05OR8QxDMGWV+XZkmuHeoycpwwClFM8RmI3f/yW+IXJhE4VA2DLvXa6JNAs24o3XXe+Du+l5qexyeQ1k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 DB6PR0801MB1975.eurprd08.prod.outlook.com (2603:10a6:4:75::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Fri, 29 Jun 2018 11:12:32 +0000
Date:   Fri, 29 Jun 2018 14:12:28 +0300
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
Message-ID: <20180629111227.GB15656@rkaganb.sw.ru>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3exdh2o.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:7:28::32) To DB6PR0801MB1975.eurprd08.prod.outlook.com
 (2603:10a6:4:75::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd620477-0328-4d0c-633e-08d5ddb13700
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1975;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;3:mDixy3in6hpw87RTuAjYiPN+9s7EaIIbcM/lJ3178c4iIhPXZZxUSK0606MAfQArharomb+wReK3TC0fqArtkrorAqgrBa8+sHjh6JAFzep5PKIY2PsMAFIUma0ijoRLuDZb4cCbWzLtpW4b9MeLD9ffFGVCbFMRLJFm7PgpeetSOgDUsfGzfMyTR0yzWkWC4UakYan8JYvQeJJZtHBy2Qg8FSU7d9UnKPdqDvhwhTFTFDjxWWkuKaVisyr1j2UO;25:nA5VMdQ/jDS44jHaSXMSlLiRivc1G2bTCsVjJRAFGzdDIF1g2ocXjgOf0vuKU6Pqpb3Xp1Nk95QYzb1niVnXKeC2RX8R8sZHP4kOnMZ1wJydURW7R8Ar8PR5Mg6YAxqegFa8s2bXYZSvEqJPHZ3Dr9QkyF78hc0zadJtI9Cu8aCOEVEQU3t3jwK/gA/VCcLQDBarIfRCZ6xlkItEkOlzNzZqH/4N06bH5GoJ8uPgu7OK8HWCE63dez7e/HFU4iF89q0IKOfeyjauYDAFn9o/wrRNAtp3M3hBT/3ZqVS2iK8WbE8nJXq4u52OqGz0dvqlFKmfSauX1Rznoa6qxi8yWw==;31:fG3RJ1S2Jym1yLnN2rY6jBEnb9193k3Fj+OiQFcvhrD+uiGk8I/ky6HFRvAcmxle0ThStFW0SpCMZ+quUBT/LCQr9PduWHaDPhX0kqasmry3OmqEQwTuRLwn8F1pZTqCHg+TqzCt0nKj/1ZPV75Xahc/Lw7gATRzBE6IFA4vVynkpPUFozfBekECJjwJVFQuaQ+icDRmGlD4yNkDcbvyz9n+A2dnAZiHXwarJudulu4=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1975:|DB6PR0801MB1975:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;20:rEP14AYwl0AcgxHq62c3XBzmxRMhZVlbyPSPEOqlC9yrndSHgLJzSeEHvi1S9Wv26CsYWzA3PZ4s27XkWH/KtE1AtCSKAENm/4eZCB1qatEMKGrvoi6m17n1lWvZR9xu0IhClt7XeN+szUGRanZegy9AS3ZAB2pHPr77FPvORaVkd26wc5WCzkOIhH/yrfTw0Y+R/TRfcMiFegxv1if/qlVDIVMsdd7ZQoJYwRKBTWbmik+kg2jk2mO6U0TE5P4tFKN9amyz7kF7niAGpKmfHKi6xnsYdLUyo27xgkTpUT+LbDjO/yafXI0qVbZxqQc8n0daXMmq7aRg/OIM762zy/9AhpP6uwfxjPRTKcQhAF2ew6YMapKMlHrLD3YAALbefSuFHTf4XBDnwrewiJjjuy+UjSkuplAWmUNGM+aHAhvDspNzl5lf4HzCGbxdxkxmr6Nx0GC59Q8MGxiaSVv2CcfBD13xNEU5RhHNhMen9/wg1dMnrgyNN/tqRKsZw9rH;4:h6nXrTnfrDKxH163TyAmExdsMes5bk6BzGWQ/1JOkpCrmCtWl9waeMUO1NIyKk/UM92v/U476QLxmFICkwqNxTplHgj8mgu2MZRCD0bm61j/ZkoDja75BIwUSFR7TIx80+8WdnSpfcPVhRar1CiC/uqPg0lg8tNCcPGD+cjV+0CnygTMDVNTayUaKUZv+4oOw4lqvzZ21jhnHYq1mpMHxKT7UACb4DgY/nyBBkvxuJoJu6o2KtOM7c3sGoG62bt/hqv9G/jqCAJ1+Nxc1xbutQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB19752A9F31C25680E61E2F2CC94E0@DB6PR0801MB1975.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1975;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1975;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(52314003)(189003)(199004)(8676002)(486006)(8936002)(53936002)(97736004)(106356001)(476003)(305945005)(86362001)(66066001)(7696005)(11346002)(5660300001)(6666003)(16586007)(105586002)(53416004)(7736002)(14444005)(4326008)(81166006)(52116002)(7416002)(956004)(39060400002)(446003)(81156014)(47776003)(55016002)(26005)(68736007)(2906002)(186003)(33656002)(69596002)(9686003)(6246003)(76176011)(16526019)(54906003)(58126008)(25786009)(1076002)(6116002)(3846002)(6916009)(6506007)(229853002)(478600001)(316002)(23726003)(50466002)(386003)(93886005)(36756003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB6PR0801MB1975;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1975;23:Te8wqcGAG3WpIjPgoRC27iczQkzhpruxJfNpLbm?=
 =?us-ascii?Q?Wxy6xdeNrwLIWmvFSCBWFiyjdXmZtubHGz7lNzkekhFRs1vLERtaF290+5f+?=
 =?us-ascii?Q?MwanjFAAFcPdNjlkUyCwyOVMTQ3TOkTFsmpEbo6GpSnBprqhXe4jQ0k6F3ar?=
 =?us-ascii?Q?XqxHJZUqyXgnbgOrsttVMFhRXoTUXuXVPwadhIVT1HoP0OE1wrr77Mem/F3/?=
 =?us-ascii?Q?H+D1y/D/OjkDvMgfjGwjBhcBCS4vEkyFkjTrgVMgh+FaP+FEdEJm+6UPh045?=
 =?us-ascii?Q?52QDpqUYyhe81Pm6btwH4e2zLXjVUZImNk0whUDhROcJl6ebvzDlTJKqFcgX?=
 =?us-ascii?Q?Ro+qthofjzMnoALs+sIyvzVL8VlYXNb2aqMLhZTQIHXKuOmMV5bKY5k9CMjm?=
 =?us-ascii?Q?8iKBNZZm1uzsCuEkNoiVk2eru6NKcRRtawBmmNmNztqlU+5Ee7yxJZy+Rzin?=
 =?us-ascii?Q?bkdfZZjoDFHpRLPb3GcfntZRjoqF7Y9rM2JeKlr8NaAEvJ2QXyJW2r1kAhDz?=
 =?us-ascii?Q?VUf4WoihPWP4wfeMqYg+xZoQXsyMuUC8xGHLVink7pmY33VUf27oz7MGuybo?=
 =?us-ascii?Q?KKTyCIo5glmVx0s39ZbLBeI9fl1i+X/M2ubsBi7nq80BQTGClEMTN3ei9A1F?=
 =?us-ascii?Q?RaS2Ecz2Q9VM/zA5XWvvszUnG2Rud7GNyQ7UJSwTRVUi5a4qMHuYt2b186D3?=
 =?us-ascii?Q?Ky8R3T/ZQ1PbwfJEQiHU2nsVw46gwAsaRUZO855skgoB83Vme44rB6voA7eD?=
 =?us-ascii?Q?XVmyNf9sgWf9bopxQ5CZirrY2qjJd0UtDxewPCsoE2Z6bnsjZ1O2ppVu/i4u?=
 =?us-ascii?Q?9FkjyK7IRQ1Kry8j4dfiZFt27Bd8UsbN81+H8XGOm4XQxHWOjcH/MXuK3N9f?=
 =?us-ascii?Q?SJRwauxfMbAjpZwKvHvfbFpB20GZOPsjBtZp5t9fqJFlhftgVDVtjsv9VT+w?=
 =?us-ascii?Q?+wQN9P7YDiC44vPi2MoudKdhEWKDhuMZpZyLbhT/Lpw2afTeIcFCV8+hcRgw?=
 =?us-ascii?Q?rUe9H85uMrH5/jZkQ3AX15BvTkI/8MA9WAqgYGq4/C23KXygwqMvZSKKcVzo?=
 =?us-ascii?Q?MC0pn/aLiZa4PygYLDFLf3qaPS2hw1V1L/sRzwTZjX39JIDPRLNHcN+QbTDl?=
 =?us-ascii?Q?pZHe/6LbnSlXrKe2j/iqDPj5XBewiNzgaBUxyy7RKnws0PwPRggi6Tv8zJ4g?=
 =?us-ascii?Q?80QCnTmLxLaZI33lJOkIqNgdPIYBCKIdo0J9AEIkhT9PvQEj/STGK6jj+bV0?=
 =?us-ascii?Q?q2uVFIJbmiEDdKkePp1hifn1+U4CCWKWlfLhOYfe4MRQUFmrec5N7q7iHeqN?=
 =?us-ascii?Q?Qi85Az3ttDyJobvfrAcS78GIbmK7rpgA0DRd8Y8R5coEI9soi00EqMOuRBAA?=
 =?us-ascii?Q?8sgJ3Psmk3eTU8vYTqu3zCjiCtjnZ0tP57tS1xdYDloDiQIuJDyy9Yyt+2xI?=
 =?us-ascii?Q?CfRbKV4z7bpM3BWGSpQXBZg/Scsrr6tCTcfuc2Zi9Jk0JulfvHC4k?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;23:tnRhdJeWo7sEMEeAK5gAZx7o3kZ4apgkMIlAI22x9+D+F45RC+HtS9eymaOdFUroAXbMn1e0iTLX9vj9+O+j3mhb/HmHu7DweC+Rx+kJ3NFRl4ReOryNQ/E0s7I6uKpYlHOZIYp4KN8/C30MuO/9aw==;6:CF8C/6WQ25ixhMQOYc3Gjw5BvKai9cCPKullUBMbHbs9BOsrF9uOn5K4413BGFOi6mF6/44FQ0sDmnIGtLSIee1v1cTMcFrvPh9wX+cSIKQ/SAGkoK+s7A4RQM1fnRlnFiYxOySWQ4TlwwBwJeNBajDGHFJIwsjgp7/EtoT++Dw3VZBJRWHDouOPQN/o4CPjwq6+Ptw1VcwUKrYCTleOUeomx5InmikzLSZZUDxkx/lpgJPfG3i0RzuU/BhylJB06tF29LSvqugz2wm0XeFNuVTWY3xSoMzaOnK2QYx/oUrkEHs16fgljevlqot52argZr4l7wwqwJ2+PVIlGgg/kkjyHfMVORQQzZdzfDCgc1dfI1CF1+p9yYa/xFc+Q9c9gHmgAyTyYbqBqzqcPWF5BQwEo/hGTB09n8fJnxlHn4s3ReRgxUcdBjJ4o6QUTPa99vY8ARUPdr7BEhIJHsmEWoYmG2Iwnoiyx3bguktdkyeW+tmAdhw0y3sRLWVZSl2a;5:0Tgzdf6xzVvIJsBdqJa+1MCfxHxWEKpSxX/Bv2FQOVR2FbYD0TUxGnCHJqrG23ZyLE4nMtRpm+xoDKBVMUFVCQslvGeK8YQqluhioWHl88oSVWFxWvVtGR5r1HpmVsBLCzw8aEPuopTQFKTIqOeyCGBcwvgk38kWJuGa/nH2ob8=
X-Microsoft-Antispam-Message-Info: 3d5i8kJUTOR/T+BT1WgPUyelP3WZIztsXBef7LBAQwGYW+xx9iQLabZmMxfMEXbtOmSspqn6eYxPpWiwNiPBJ5ntKkaDO7uxbuCA3vNKJgBkxv53RgL50Ox8jF6pPq/FPNyIxhv+zkUq+Jo/pyD16tgrri4A0L/ye2JdNtzdruvR4FbTIh5ividqLniZolOMboe2Or9RaLKOkZ2DNIuRXvDDEJy7/LZSgQMm8xzNose871tWMTZRaUiLB5N/d2ldBgPo7EX7vQGudnewkJ5e2EhyuI0eumTAL0HplG/C3R7MN73JKb8tCi07gXdjqlHq/qOZG1pOn6pP1cku1l5W/YIAGESXBx17pgwVrkV4hFuuVMdXvQN2w+2O9HlniH9YQePUk0n17AOIpdYAZJOwynKYRFSu0tjeMNioUMf716ZiqVju8nzdfZyuqgb5mVInvHcYZUCRC5Fnn9uh4TjN+K47s/4eFGJZXFATf44CWUo9BOJNhOAgGNwCZl4c0UauxV96z5muevfZFUolvX6TUruyQ5bE3ihb8AFGdOxkE7Ue268CvV1tttog9EGI6WAe0XAjEf17zNiwgC3LKxUWgg==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;7:8t2+jgvnZsbcMWxkl1uW5sGuflj/uX4ZoxZNsv49O5kSsVOawoInDLAVOJtLX6gTphgrxgiiz7lANlRIbB6IyvMrGqlK+ZVRCBe6nfOpOt+lUkV0J01QjSIXwKwshAcnH+uffqHgndgw7c1XizYC3M90m1Zm5Yjti3MjyZyJCndCVKu/eFf4+Cm8z1InIIvwcj9lBv0sPM9AXi0uMkeaNcWVsjwEqGSQmQ+2CbRSKhTEIVx6AWZScDfOlp7jJbas;20:LyW71dKFqJq8J7SZk9zijZbBkbL9gtbtjW5ut7K2D8JXgkTrHHQ1vPm9p39nmkODHkj4BX+vjH2aVwd2tDU3bEOR4scafVRkvO3+d7QLUYa4ozeTmY/lkYzEdLV3HXWAJKqFqUfkoEz0Xo3M0b+mm5m6HEQh1FDcpgKxooGe6aY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 11:12:32.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd620477-0328-4d0c-633e-08d5ddb13700
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:26:23PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Thu, Jun 28, 2018 at 03:53:10PM +0200, Vitaly Kuznetsov wrote:
> >> While it is easy to get VP index from vCPU index the reverse task is hard.
> >> Basically, to solve it we have to walk all vCPUs checking if their VP index
> >> matches. For hypercalls like HvFlushVirtualAddress{List,Space}* and the
> >> upcoming HvSendSyntheticClusterIpi* where a single CPU may be specified in
> >> the whole set this is obviously sub-optimal.
> >> 
> >> As VP index can be set to anything <= U32_MAX by userspace using plain
> >> [0..MAX_VP_INDEX] array is not a viable option. Use condensed sorted
> >> array with logarithmic search complexity instead. Use RCU to make read
> >> access as fast as possible and maintain atomicity of updates.
> >
> > Quoting TLFS 5.0C section 7.8.1:
> >
> >> Virtual processors are identified by using an index (VP index). The
> >> maximum number of virtual processors per partition supported by the
> >> current implementation of the hypervisor can be obtained through CPUID
> >> leaf 0x40000005. A virtual processor index must be less than the
> >> maximum number of virtual processors per partition.
> >
> > so this is a dense index, and VP_INDEX >= KVM_MAX_VCPUS is invalid.  I
> > think we're better off enforcing this in kvm_hv_set_msr and keep the
> > translation simple.  If the algorithm in get_vcpu_by_vpidx is not good
> > enough (and yes it can be made to return NULL early on vpidx >=
> > KVM_MAX_VCPUS instead of taking the slow path) then a simple index array
> > of KVM_MAX_VCPUS entries should certainly do.
> 
> Sure, we can use pre-allocated [0..KVM_MAX_VCPUS] array instead and put
> limits on what userspace can assign VP_INDEX to. Howver, while thinking
> about it I decided to go with the more complex condensed array approach
> because the tendency is for KVM_MAX_VCPUS to grow and we will be
> pre-allocating more and more memory for no particular reason (so I think
> even 'struct kvm_vcpu *vcpus[KVM_MAX_VCPUS]' in 'struct kvm' will need
> to be converted to something else eventually). 

We're talking of kilobytes here.  I guess this is going to be the least
of the scalability problems.

> Anyway, I'm flexible and if you think we should go this way now I'll do
> this in v3. We can re-think this when we later decide to raise
> KVM_MAX_VCPUS significantly.

Although there's no strict requirement for that I think every sensible
userspace will allocate VP_INDEX linearly resulting in it being equal to
KVM's vcpu index.  So we've yet to see a case where get_vcpu_by_vpidx
doesn't take the fast path.  If it ever starts appearing in the profiles
we may consider optimiziing it but ATM I don't even think introducing
the translation array is justified.

Roman.
