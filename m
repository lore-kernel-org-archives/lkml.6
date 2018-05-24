Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032311AbeEXQym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:54:42 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:41376
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030681AbeEXQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:54:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <20180523073239.GC3155@nanopsycho> <1527065574-11299-1-git-send-email-vladbu@mellanox.com> <CAM_iQpWNRRND4+uav4Sqwe1ctsb_J61eueShaSkRmYeW1=KMJw@mail.gmail.com>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: sched: don't disable bh when accessing action idr
In-reply-to: <CAM_iQpWNRRND4+uav4Sqwe1ctsb_J61eueShaSkRmYeW1=KMJw@mail.gmail.com>
Date: Thu, 24 May 2018 19:54:26 +0300
Message-ID: <vbfsh6hhu4d.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P194CA0036.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::25) To DB6PR05MB4696.eurprd05.prod.outlook.com
 (2603:10a6:6:4c::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4696;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4696;3:Dm6DH5d9aa49xyKE8s3IXBMvw6hXCki5/zCeYKFEJVISt1X2g4CYDxUYqK5A/29qUB+A0YXRDA8PXMTJr91UVGQnemvODUEtNNHlOYnxUCVHe640VF+YpBMuItc7G9xL5f+a80bXCO9jyFvCrndpPsj6rxwGBkywATzr0cMeVYQTjcLqC7UcmijG0Ij/lr0sX76jAkgil3Wz3dmkmiGlnlBBZiIxzzZJs6ko22fAziOa8Oc/ZDacI5PE12sWX9d2;25:8d/z6pB0V14ArZ/HzY8bUC9xQDdviIJn7Lv81YamxCHrU1DsOvM5d9hC128g7obx80Qo2NjhtU6Yiij5FdOklSTsneca/z6fq8PcUGwITTe57pv3r10WzOC495iTo2+FMVpk0TcGGcwlZbIAEX+DUlpZ6vf89IpIoNv85zRM6PCUSiHERL2SwGEvjFmX8U3P5O3TPiuIMH6mwT10LNcJ/DNYiKVILOl9326xPaceHG6DJ9s3oh6uSlMZQrZaBS6yTLSd7qGvWFOj004ZOUhr/ZnGmg7tAYf1CPaD2VOUPIbtN9sZSwLmp5hz+oXpPZmm5aFvuy31DEQ+w1qvhCRs9w==;31:xJBfG/ZBM48rkaU+nqzuSqUFj647TtWY4DxZk0+xJi0NfUeUx75xYiWVPaYhi5TdT/cBjdEPtYUgbQ29Beu2HvdBd8ksJQgv/Hjf62ZkC2t77WNmJhJ9NYbPE+g9CSJhf8D53hxenPQ9pEzo9LuOAJxGXrtBargrLAEi0s6jM5ymCfYTQlvkz/adqTucYKgWwelzEe0nb2Iu4kavP4odmhOtoc85qhQpC12BLm8ruXs=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4696:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4696;20:g8UugvFFbNjVr6Y4ZTxE+2l6I6RKWJ2uMeyb7PtmmwiTJM2Rvc2/2KgbDcNNuaA5DQPk8df35m/zgY7hykR0RhYdBBPPgRA/C7zYqc/TrQSdni1CZZuNk7vgfQZd4uZwM+19HFhAYM2pwxGtvuVM5rgMLw4YxkR/aDnh/QpKaGrgwaCdfRaSt/NL+JqBPFkQEya/g2+ZoSI5J9zDlIe22qt5cU0qaIC0Z50bopkvR7EjVTAQna+IcKDZ7xGWdeOxuGEteuperW9OuEoCAsfRLXogxq05syShCicT6QAcxJ0JiOTqSqJV3BAORyCq22+lqh4nn5r9QAkRSV1e8GdMX3tNOVYCKPrfRsGmU+ap8C6VhhTR3+ZDocS5+E5STZPoSZf4cqE2bu587ofigbHAjZB/eWkRPlM90QLdWyhRDqyAeB1PTjTLUwF9RbFsJH/0M97qzhn/UPXLisZlo8ukzqj3TytmKqKpDQm0o4wsBOFoYgoR99XQQyDQ3TvxtGHg;4:zmRZwnt2MOpM4/lJNBpTI+SfidsQTBGonKsL4P6ter10vlIxmthFt0j6E16aBXsqL3UsxwlnizCUC/2I0pQRGEwtRYwRC34uJJfKLgF8jxUrr27Qy1iYrZByOUXCgqXFac3pp/AV7dBVTnfiIleXVfQ1z032DU/O0XtJwSjfmNVdIkug6p0E8MYmhKEu160/WOJvWg13I9Xa3bsN6j7e60M1uuvL7f4mB3sZSTr772Rywbo3PdxOVc/dWuQmiIgBLM31URor2ZpykxF83wrlgFsIwryeQdzcyKZQat/qAv8a9TzapTeEGongoKSy5+2m8/ZJj0Iv07+cRR8vrQZ+OYRTWygkrPIXRoNOJeBFHnY=
X-Microsoft-Antispam-PRVS: <DB6PR05MB4696E261CC1B340844BBC714AD6A0@DB6PR05MB4696.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4696;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4696;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(52314003)(8676002)(446003)(11346002)(486006)(305945005)(345774005)(316002)(478600001)(6666003)(97736004)(3846002)(59450400001)(39060400002)(52116002)(6246003)(7696005)(51416003)(76176011)(4326008)(6116002)(53936002)(476003)(86362001)(16586007)(956004)(6916009)(47776003)(81166006)(81156014)(66066001)(8936002)(54906003)(106356001)(58126008)(5660300001)(25786009)(229853002)(16526019)(26005)(186003)(50466002)(48376002)(7736002)(386003)(53546011)(68736007)(105586002)(6486002)(9686003)(6512007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4696;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR05MB4696;23:ABVKapNxqhaLkAEREN4IjM9E0DwP8DrdDOjeYfDrb?=
 =?us-ascii?Q?ap7m1y0BtXjwRV80mfwRWNdRK83MWdLeI21bTZRTBsvT/JgK71xpZ+RQA7+G?=
 =?us-ascii?Q?JgWntpmI3EfHDv26hp38sVEnhiBizygZd6lRB2J0Liy4qUPPrwJS6Yq0iugM?=
 =?us-ascii?Q?OcbV1gTVhp6o+oyqaTeqPJAQqyFb30GnOrGNBrxzfycjGtjw3MCljIq9wMwI?=
 =?us-ascii?Q?5WrGSbcKXHK7pXjDnG+WsjACgDoBWT5PdjzHYwqQcpPaIvhgNPpSMv18zls6?=
 =?us-ascii?Q?L41DUFXBJtwGW1qB2Hyx7fsQs5+BU4cUMqRcu4LlvjyT3OCl77AE5n05WNtJ?=
 =?us-ascii?Q?Av416Ifa/avZp43Y2HPE6YPhc+fbn89txQhcaChXY8aBIpt60II89LkMUjds?=
 =?us-ascii?Q?HFSIYqyzNt/khtilg4J/nzHE1MGF+mTnzmlgnQqxRxt4IEKPM1erGKJ/1Hts?=
 =?us-ascii?Q?6Ol0nvBGI+w/Z0nHMZ6EvZH3YvVtbBprWUfDe7OKxdDiAroiX1vowM82CLZK?=
 =?us-ascii?Q?2YBB/jMBLKK1jf7zvX6bJQh2iKr2VJEutSI48eVaU1f4ulU6HLhp4hLg0fNb?=
 =?us-ascii?Q?Uo1SjmCWvIvJT5BvCjSxIRmlZoPw6Zj9NMNIeNPK8PjvelwlmyQU1dTPm6E/?=
 =?us-ascii?Q?VUpCruFChBpx82UyQPHG+DN8Ir2O+fRM3iwcr/ubb+Xb72J+n4dXm4My5VwD?=
 =?us-ascii?Q?/MIP2xgwxOHkITt8SB5WfvAeDcGqoPWJyWP2cGg/qfTwsKjweTdNlJnr712B?=
 =?us-ascii?Q?ucauKFsPVnP+dlbsL+VR+B+f+iYdJFD8aMK9nYailiUCvE2DCqCaSLRdt4hN?=
 =?us-ascii?Q?kevLHvYWZF9CgUl5lBm5n6jUZfzRxVYLPh2c84hLvR2MvFK3AFc5DvjbSr3+?=
 =?us-ascii?Q?U0+DWcrjgSV0TlplrUO4Rj7iQN4jzrKeOetHCmUfou3G9sYngB5ExkGt/QRX?=
 =?us-ascii?Q?8hqAV94pcfDQ85L3UHZM5JFUyUXCoFVA8ZCwAv9QfWtpCaVBfL1fH3xfU+Xi?=
 =?us-ascii?Q?GXXUmQIoP1C6w/of/vbQ3qm9W+i0Txaw+OJ2EPqXV3742JmFuAcA2IT4QSRS?=
 =?us-ascii?Q?P55vwKaoGNawJ+WrpIQ3qtPSouDmPuhz6OwVjw7huU5/C8BMIMN6RXjXQYYy?=
 =?us-ascii?Q?hImn2n1qHRp0t1IuWEyz/gNNUmDza4QlOtc7terI9ivCn8glT/vNQtPZlui1?=
 =?us-ascii?Q?ZdFJAU5t24F6mu/yMieHVirDsiEiAy63kI/tQkL/dvEL37al8ng2UFGJIjYM?=
 =?us-ascii?Q?ONa0VKMOMerHtl9rq98J+kQtj4+a0ktPIWmeQocWC6onmnTwqYlpFVOodaK5?=
 =?us-ascii?Q?eokOCRPe03QXf3n3pDfPQ3vHCgy5tw3dn6qJlcXSACP?=
X-Microsoft-Antispam-Message-Info: QylX+hksWZTL5W2tiK4h4GOuwun0Jegt9hQ7eWWeuWpxJsLul02pMDojDXDQJK/A8RGmB+4S19G/sbyMnxoYVNEPhWfwKxMQxhzi52kyb6D0dENEAFTTXuPGpH1/kar/MWe/MD5COgkQibUXAuccVSACuvcVvyf0aEg+hehsWfsmDJHXcXDMkT6l10uEebC7
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4696;6:hCqvoAoYpLPP4IxeyIPOnOqUeBNZ68pmwqerDODAPnBHbpzbgMiOiPv+SiKwXYnlrvgugRjzf8MJynTBtoLR7DdP09UwHsBpscBKRQQCHPEG4dNeCE6eMrpX9/K0nCAkATjJS8u6AaHnuhJlaXRxryMYg2l00N8W3OA/UyPfscP/H5FQUQ+64dQVxV/lRlyOGUBM1bV70X0DF0on/0nyhNehPcvuXqU7IVs4UTZKnRnuXjO31wyT7qGD5fWkztZoXg/T3R0F6vca/J3qeq7lDKBdnElkKtvjGzdPZYbILJgfeZW7ZsyRzIfUrh+6ZObg2r/mNuSWJmhESiAeFozoFMynq/pY8Jj6ifbYZ2AAqgP3yAaocA0kkaa7DG4SK08GdkgsBadBjtcQGhANVwH/77pKpHzGKZj6lUUDqJ2R7Ln/zYsfrmOmFYC2+LL5k5vnhiLJBOKYr8zWaHyICxUunQ==;5:GzJ0GEAVavKP2vuIxOSKb73+3qSIXtNi6kPZxQAZXidZbwTofphc2sAcY7s+iaJXq8MP2Vyop40brGdhJnBdxXHfXPoYS7CAzmMYT0kJx9YPPgewB40ge6A7TCO3hQk0v3JmDhHxha2CHuA1zDOgTtqWsZO4rnPQFBCDArLO34g=;24:BilYYooNK/hwNYAly0AjZfFyPCVBzjPHilqKd5raU3TX6eQXX3ATDtosAocU0x+1KTlA6SeZuL53UXw6bsQyQoB1uwVFtJPe/M+HKzbK/2I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4696;7:SNRlL0EIrwahgWOCgMV0tyuy80ZiVO5TBP9Q1ATZzy3pHjdMC+LddiTWTgfcFNw1DbfCE69Y7o+6ik7ZyUfCo34PRZSgTmKSqSdqblhy5k0Rx9HObqkBxbAk7AG5DCY/H4qkHzNGD5/4mJZFt7+01qnnVeFLbT4ixQnRHQ6Zh01Hl/nRHmBElEFlzcbE2V8rq2nGHYpT30iNzZc1g1dzXk40fEjzLSp6igaTPECVNdHLmByxCLkyDUuP07Qvl05h
X-MS-Office365-Filtering-Correlation-Id: 244cd951-c3a5-4568-7a24-08d5c19706a7
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 16:54:32.5842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244cd951-c3a5-4568-7a24-08d5c19706a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4696
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 23 May 2018 at 23:14, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Wed, May 23, 2018 at 1:52 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
>> Initial net_device implementation used ingress_lock spinlock to synchronize
>> ingress path of device. This lock was used in both process and bh context.
>> In some code paths action map lock was obtained while holding ingress_lock.
>> Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
>> modified actions to always disable bh, while using action map lock, in
>> order to prevent deadlock on ingress_lock in softirq. This lock was removed
>> in commit 555353cfa1ae ("netdev: The ingress_lock member is no longer
>> needed.").
>>
>> Another reason to disable bh was filters delete code, that released actions
>> in rcu callback. This code was changed to release actions from workqueue
>> context in patch set "net_sched: close the race between call_rcu() and
>> cleanup_net()".
>>
>> With these changes it is no longer necessary to continue disable bh while
>> accessing action map.
>>
>> Replace all action idr spinlock usage with regular calls that do not
>> disable bh.
>
> Looks much better now!
>
> I _guess_ we perhaps can even get rid of this spinlock since most of
> the callers hold RTNL lock, not sure about the dump() path where
> RTNL might be removed recently.

Actually, this change is a result of discussion in code review of my
patch set that removes RTNL dependency from TC rules update path.

>
> Anyway,
>
> Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thank you for reviewing my code!
