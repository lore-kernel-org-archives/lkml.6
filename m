Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C596421B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="evKlTM8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C596421B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeHIKnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:43:51 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com ([40.107.7.104]:19265
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHIKnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eysuHhm7NU/RDYqzaGe4KgJdI92HzEPh0GSlMFlIHg=;
 b=evKlTM8xZ+XUvJIto8ORG7A+IFGKBKzRA9Iwvk8efN9/JXOKEXB8bAyUlrm6wAg73qjeRI30XRw4ds9c4BhD8O337m+CRHeHPnATEhDI9iE4RMjH3dL+MxLK/7a88KQ+JQvmYCuvC/jjhjRh1pRWAVSOXCVWBgnOR5We1BcZrAI=
Received: from linux-e4ne.site (79.164.103.161) by
 DB7PR08MB3115.eurprd08.prod.outlook.com (2603:10a6:5:1d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Thu, 9 Aug 2018 08:20:00 +0000
Subject: Re: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible
 processes
To:     Murphy Zhou <jencce.kernel@gmail.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
 <CADJHv_uWB=kS0=rFnaAUFk1X+xy3BWHH=6pOk+uJQNBQS04hcg@mail.gmail.com>
Cc:     Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
Message-ID: <0f167223-fd55-7629-2eb0-48ec937668d3@virtuozzo.com>
Date:   Thu, 9 Aug 2018 11:20:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CADJHv_uWB=kS0=rFnaAUFk1X+xy3BWHH=6pOk+uJQNBQS04hcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.164.103.161]
X-ClientProxiedBy: VI1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:803:14::16) To DB7PR08MB3115.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 757fc614-3904-4ae0-4af8-08d5fdd0e76a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3115;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3115;3:NCyOz6NBjmk9CblfVXFodCJ5qIbtLejdI/VLMheNhJpTOw7XqBDH2GHg2zxP4LIM808EBLYxG/NB0gS8PrLMiy14c0PUjJCPTOGiVupf1P3uuZHxLnTLkGieU3JWo00cusTsBMBDykRm714XLCNt+txbeMDzHIFw0vnqfRU/ySxRZ5O5NbSDEyUjj8ujZZjBB3umC4RoXmpF2/s5LOMYTO7e9dGMTdHov7KQfspKcR1vCH8U7hXI5j0fn4OjhD6c;25:Cr1OaFhJuyGycHIJ+llV1O5OsBRBgzKJsd7QGe8skj90c4AIYNC/0l0RhE2F5Ctp4V9G8uci5GkfBKAWpfWiOHVsDEy6c35IoaXyWojx6Lt1CgN0r9i4T6dxYe0DmVdQjKpV7stecgo4sxZ7o35QtAlIetk9tOmimp04dxWK9DXglPzjjUK6KRNGlCbsInJw8La6dg4sJAJp4DWN35xZ0iZ0rBRJef6kJwCzN71RTdxgME7djn4l2V6rvTMd05Jiv6lSOL023bRPJyJUIGFcHw7hmnEX19wZBvPDgTHLP4N4mOoKy58QmmBiTUr/lsMjI8oFHtltcWWzQhox1cAZyA==;31:gDkFaD/5C4vGOOt0VXqGJU7nI92JGFhkMsljbVDu5kBiFHu5DJZzVPxOVwZEyqRwuZsITBruhd7PACmXD8nC7l+AuRNcwvZGxZ5fE8+hMn5jrCca0ynaYOC6+88sJV496JXL5FK1Nke4XxxaGwQdgL1WNlvXPt7/3rzdDrTlwGQ9c9RNZMtkNm0Sciz43xyzyb5tESwc4iCuGYry8NNPm94AWfPf3vZ9SJ+mGSGwVsE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3115:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3115;20:Db5bpEeoVOBXvqHzSr8OzInoUYJEm1UKNiJAjsc8Tw9KQLNBaeckKqYqsuEci6bG0TMp94vOJ+nO+p3xsKkmc6SrGH/gtr9ZEethztZtUpG4RynQioSFgUh86Mn3PDdi24nBShRc6uc6JcrClPTbQzgKMcO8Oun5XGlXQtTtcjB+z5FMM0cXPwv9BYAY5a+2z210bpFr6hnJYGRnzRwk1pYzSL4trco6XjPP607DXScT5AI7JOnNBBhDC4no1N+k3xun+qcqRJWw6DqNEn+n0SoIXfYStemb61avJUxgcUEJ9F3HhVM9Fzm5NWkB0ywBP38bodEzPzIt2VFCaRCo0mQgEZC8sT1KJaBNLSWzi5yLZ7YiDnit8mlz54lMnIG2pZLBfIeKmV00OnMlhRn2prLloNFXJc7eD4l0UTPrCl3wXJrfcGIFt+JkfUEd0LcM1aXBAlxodId4M3pKIUD5qeK5PRiZ+RSdwXzkTIlmpuQ2UhcWXgQMmbnPQVDnAJ7f;4:lv2ljdS7eiyps7elv1Gi5VwPbtUu1NKDUuTPler6Ku5hFJnekiTvP38i9UTh0PTW+dTVusTI0UAkkvfO03IvPpJF5AKSkGOuZ2z958CpK612FvZsEPZaGFj6tHQLZbZwtSWWnMbpr4a776yHF9cDomi5HUcthw5RODQpmY0cukYgTOfN80HEY12Tj7CQJaa4CCy1QylQnErsm5BrrhUb/Lo9dKhx+i2jK0jD+H7wHjW2Tp+JoJTS0BjdSwqhpeIfMSLFh2s2VdmLADXFMacdVQ==
X-Microsoft-Antispam-PRVS: <DB7PR08MB31159B264BBE41A83DB06B5EC8250@DB7PR08MB3115.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3115;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3115;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39840400004)(396003)(199004)(189003)(36756003)(6486002)(23676004)(58126008)(69596002)(54906003)(6512007)(65956001)(316002)(47776003)(25786009)(6246003)(52146003)(64126003)(39060400002)(81166006)(67846002)(65806001)(66066001)(5660300001)(50466002)(4326008)(81156014)(2906002)(14444005)(229853002)(2486003)(305945005)(76176011)(52116002)(7736002)(65826007)(8676002)(31686004)(8936002)(186003)(16526019)(26005)(31696002)(478600001)(106356001)(105586002)(68736007)(446003)(97736004)(11346002)(2616005)(956004)(86362001)(486006)(6116002)(476003)(3846002)(53546011)(386003)(6506007)(6916009)(53936002)(21086003)(230700001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3115;H:linux-e4ne.site;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMTE1OzIzOnU1STd3VDM1QVJvVnBDOHpsQitQbTlWamF4?=
 =?utf-8?B?ZnlsVHRlUWNaWDlGSDdKOHh1Q0dvVUZ6Vm1MN1h2ZnlpTCtvR2x3WjVJOHpE?=
 =?utf-8?B?RWFWQzVrY0doVElmeFdIWVM5ZW9VN014Z2RGa3BNZFkxVHlVSFdGMHU2QzFU?=
 =?utf-8?B?ZWhmQTNKQ3E3eUQ4N3BUblVmckZpWWthNDBpUGE3VEFKQ1AwTDRDNmxTcys0?=
 =?utf-8?B?WFB1Mm1yb1dQbk02d2t6THNSMExxZXhCT25MaTBEQkZ1YklNRVRLbVE4NGtC?=
 =?utf-8?B?WkZYQUxaN1FvR0FSSkRWejJ4WXk2NnRrRUVMSkRGMit2a3RsV29kKzMybHhI?=
 =?utf-8?B?UG01Wi95ZXVaSENiSFVDSHZsTGVyc011RWg1MVdCTHRMWURBcllhbTR3Snlv?=
 =?utf-8?B?VE8yVkx2OFVsVGlQaC9oYnI3UGZONlpkMWNUQmlPZVp0RCtDbUUzbWgvYXFF?=
 =?utf-8?B?eEZidlBSWkppdjZOMEhlbXNWZCtEN2ZKcFZidGsvYUxYZERFcldkZU10ak5I?=
 =?utf-8?B?QXk5RnE1K0RnRUZBQWNHa0pqL3Nna0o2ZW1QWitpdm9mLzZRNVBTcWpHM0Nn?=
 =?utf-8?B?TGlOT2RTci9ta1JkTWlMTmp0NDlDR2MrQnRDZmU2b3BTSWZJYWVLN3cvdXNS?=
 =?utf-8?B?aExBK0pKOG9ndzFvSE1QdW0vUzdTRXpFc0k2TXhwSzduT1dXbUZIcnNpOXVs?=
 =?utf-8?B?dVpvdmlkVWh4N3ZENFBraTJyUmM0WmlwRUxLMnAzb29CeEV3UTJzZ2h6eDk3?=
 =?utf-8?B?QlBJQ0RKdG1MNWF0L0VIc2lMVkFjelM3a04xL1h4Z05tcElQMXI0cndkM3BF?=
 =?utf-8?B?M1IrTmwzK2FKVnBPQ1g1YWc0MUpGTzl0ZFVRYW9IRUlRL20wT2M2MVlPSEox?=
 =?utf-8?B?ZUUyVzNGSUJNNGhFdGVILzFTMStXT1MxejNCSTZ2bzFnS0VxUlp2MTdjQzZ2?=
 =?utf-8?B?OWRhOHlVMlhiT21ONThPRG12aVJNVVgxYVZ6cExJR1VWTVdEYmRNb016Ukta?=
 =?utf-8?B?aERHbms2SHUwZ3ZqY09tQXI4emo5bnZKdmt2Z0xhbnFvVldCTXRNeGVEMEJh?=
 =?utf-8?B?dUhhekU3am9Yd0pDeE8ySUNaenFqTWNSdmJreXkzUkRSLzVCMXB2SmVYOXZ6?=
 =?utf-8?B?QXVKU1VCbDZPNGliMmw4RjVybE93UGloMW5GeWJiVVZrK2RBSWZSa091U052?=
 =?utf-8?B?elcvSFRQOWMrQk9hV2tJNTR0WVJ6Y0loM1FXZkJac1pKVFJJcks3Tm03SzdG?=
 =?utf-8?B?ckd5MXN6RmRJYUkxZnpjQkN3RVhwZFNza1lBZkQ1ZGdIVmMybmkxOHFKMGhk?=
 =?utf-8?B?NG91ZHFuWVo1K3ppa3hYSm5Vdk1tODQ0VTFyMHNyNnNxUzJBbGJxTUx0KzdL?=
 =?utf-8?B?Q3NFZzNad1hjUFJXRlFML0x1OWo1RHFLQ0ZQalRvK2IrUktsbktmRnJ2UFMz?=
 =?utf-8?B?elgyVE5LM1pwWCsyandTVkFQZUVwQnU4ZEtZSU9LRUVlKyt1RXp0dnlSVml0?=
 =?utf-8?B?d1IzcHMyZVBJSU1KcEZoc2M1VkVScEIxU0R6UGYrQVphdjg1dTFSWXhobmVi?=
 =?utf-8?B?dlREOUNOUVVpMXpBdDc1R2FYZi9jUnpYOUwwSk1uN01CeDhmRWZtZFBjNUQx?=
 =?utf-8?B?Ky9NbG5XNjAydUxpV1FPQXJpcUJ6V2VYTDdZZlAyMVJXUkk1eWFRYUFOUDBQ?=
 =?utf-8?B?WENYZHJZU1Q1UnJ0WWswTlpEcCtUZFc2cXVRWkxGOGpLdmM2TzRvbDdkeHRH?=
 =?utf-8?B?MnFCN1N3cmw5eDBQMncwR083Um1ESFhMNjZBbTIxS1o1d2Jja25sWXVUdmMy?=
 =?utf-8?B?NldMdlpTb0wxUUJidUFrb3lGdVJpQWQzM1FUelpsQm5kbTk1a3VVbzZ1Uk1t?=
 =?utf-8?B?RlBlc1drSHJyVExjV3N4TGFSc3VHZlM3b01lazFNM3AyRVo5cWN5L2xVVkVl?=
 =?utf-8?B?M0hLYkFsRDAyZTRjWGpBYnlHVERJL1BOdC9aVENTcTNoMm1ZOTJzSzlqbmhX?=
 =?utf-8?B?SUpQVTRmUkZ5WllLTkFPV0E2M0lGMGNHZ0NTZz09?=
X-Microsoft-Antispam-Message-Info: 5zLKX9RDCZ5SRyoFjFFfnQtbwoQFkORRs6RUJIDjcfLtuU1bH9/k6S9KSM6+TLDRKrc+hVW5jaLeZpdJ3sICBSdX37rntqwW+AeFIHWVj3wleZq7/Tg3FjuTmpOhzW2j/wTtZQFXgngmGrlMjhTp9sImay6NJPGOtnNIxFchUpz0qxwaN8Er9KenLnHLkvMcXS1JVdlAzluiLLU95+FpQ2awssmtCfZLyRYOqwdnUf4/76/UIxOp8fb1o2zccWb2jKOEzaYQe1vKNtgc9ZhOKR2LXRP6FROuyStJiT9TdOc43RiARn8kjztUd4dQTqPF+rnlFsOOTo1SzjmlfQ3IpwTG7GIqpe2QsAw2L1bQhuo=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3115;6:FZtzrTo3IZUAawm+uhTDWFnqzsx6JcZh9A2B+wkVRgvBp69vuP6xrRM2kabnpq3MZ3g1saRY66JHEu738ZAQLIUhsOCmxHcF1bPx0j73Xb1Ljl1+S+QeeObrDi4pJmGJDA8k2LR7pYIMv0gx73z55CntJonanUnH5wZo67q2TUy2gSK7DwIXErkYWiYHvz0GoMt5SQ/WXOV3GGX6IlX8Ea7SSPxbSsdWyB0PnGP4ZhbU1X/oXe93odVUoNE2IFVjwBQtQPMNPwfzYtqELhRMr9Y+JidE/S2jjJSDm3vJBQ9XfWo0ATJRjS5Gg5FgVnTs+BWF0CDoc5cRwVXPcQJn1jthKtFCS1iA/9BUbKraYA1SCUX697NQ3HAprJRYRAzWR5AmkKzZjCK6ZnFfutSGAwrTY2Gg9CD1ItJM9VRp3LECbbdA31imh7l6kxmnCyBvL2wjdslkb7a9/mkQpDRwFA==;5:1ChaBHfXCapmxOpdPq3il8OJ564Cyh0RxdxWr938Bs4vhbFmcG0cJe9nhAA/eaMa745kQlLEINiEcvTOT3FjHkigJ9Hj32fOoUklarzWf66RxOeHo0b9vS7sjFsDwYsEHmNBBCh0YJwI6U8lzwIa5BR8Ba2HrYTx8bh/+73gs24=;7:NKiLmgfJVtxxzc4kg3N7Iuz2pqYiXKguLQRwHEKEnascjsAiZMpy2uGrWtdj59wc9IsgMBUJfM0CzolRi3cqb5nAT56jLZAVHh8Om0WARoTXv1ZOsfZ3NN0RcNqMTzMUhUwc0SS6e96l8azLMZJcx4MpNz3GJdDyNgQGgH34hiuHQo48Yeh2RYM+kX+Q3mxejEP/BXKEd4dSrbTmRihEx9hS6iQRDGwpd/6mCfnCWwdLlgvd2X7czgtTMjhwf7OD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3115;20:618MNzYdKMSymQLk/0rDrYx0KSRdVdSVS+v3RDTNYWS+TlwVopTgRetljBPhyDi+KirsZq4mmwGUPKgRORK2L6/DmDlF2yUqBmHPGUBhhFkoi5v92ArpfdsvQ5SsBLcvf3cmNWrLTbLXzc0rFh/GMyz9pMKDx1PtKStohwNJA14=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 08:20:00.8914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757fc614-3904-4ae0-4af8-08d5fdd0e76a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 10:16 AM, Murphy Zhou wrote:
> Hi,
>
> Looks like this missed v4.18 ?

Hi Murphy,

yes, Jeff planned to push those patches into 4.19 and they are in "linux-next" now,
but not in 4.18 "master" currently.

On 06/14/2018 01:41 PM, Jeff Layton wrote:
 > These look fine to me. I'll plan to pick them up for v4.19 unless anyone
 > has objections.

linux-next:
1cf8e5de4055 ("fs/lock: show locks taken by processes from another pidns")
826d7bc9f013 ("fs/lock: skip lock owner pid translation in case we are in init_pid_ns")

--
Best regards,

Konstantin Khorenko,
Virtuozzo Linux Kernel Team

> On Fri, Jun 8, 2018 at 10:27 PM, Konstantin Khorenko
> <khorenko@virtuozzo.com> wrote:
>> The behavior has been changed after 9d5b86ac13c5 ("fs/locks: Remove fl_nspid
>> and use fs-specific l_pid for remote locks")
>> and now /proc/$PID/fdinfo/$FD does not show the info about the lock
>> * if the flock owner process is dead and its pid has been already freed
>> or
>> * if the lock owner is not visible in current pidns.
>>
>> CRIU uses this interface to store locks info during dump and thus can break
>> on v4.13 and newer.
>>
>> So let's show info about locks anyway in described cases (like it was before
>> 9d5b86ac13c5), but show pid number saved in file_lock struct if we are in
>> init_pid_ns (patch 1) or just zero otherwise (patch 2) like we do with SID.
>>
>> Reproducer:
>> process A       process A1      process A2
>> fork()--------->
>> exit()          open()
>>                 flock()
>>                 fork()--------->
>>                 exit()          sleep()
>>
>> Before the patch:
>> ================
>> (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
>> pos:    4
>> flags:  02100002
>> mnt_id: 257
>> lock:   (root@vz7)/:
>>
>> After the patch:
>> ===============
>> (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
>> pos:    4
>> flags:  02100002
>> mnt_id: 295
>> lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF
>>
>> ===============
>> # cat flock1.c
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <sys/file.h>
>> #include <fcntl.h>
>>
>> int main(void)
>> {
>>         int fd;
>>         int err;
>>         pid_t child_pid;
>>
>>         child_pid = fork();
>>         if (child_pid == -1)
>>                 perror("fork failed");
>>         if (child_pid) {
>>                 exit(0);
>>         }
>>
>>         fd = open("/tmp/a", O_CREAT | O_RDWR);
>>         if (fd == -1)
>>                 perror("Failed to open the file");
>>
>>         err = flock(fd, LOCK_EX);
>>         if (err == -1)
>>                 perror("flock failed");
>>
>>         child_pid = fork();
>>         if (child_pid == -1)
>>                 perror("fork failed");
>>         if (child_pid)
>>                 exit(0);
>>
>>         sleep(10000);
>>
>>         return 0;
>> }
>>
>> Konstantin Khorenko (2):
>>   fs/lock: skip lock owner pid translation in case we are in init_pid_ns
>>   fs/lock: show locks taken by processes from another pidns
>>
>>  fs/locks.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> --
>> 2.15.1
>>
> .
>
