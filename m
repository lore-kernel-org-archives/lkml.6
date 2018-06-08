Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NAJYIauoGlsjQgAAmS7hNA
	; Fri, 08 Jun 2018 16:02:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69A19607E4; Fri,  8 Jun 2018 16:02:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ccs5kyha"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3BAC60590;
	Fri,  8 Jun 2018 16:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3BAC60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeFHQCs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:02:48 -0400
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com ([104.47.1.92]:16373
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752724AbeFHQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpjmQtePPtu2O1BJxoqrT/EQuPu5y1fJVZJHqMQjGH0=;
 b=Ccs5kyhaTWwdpxZkSbWKzNjeJvl2w5avK6QLRP+ROVTK5yTH1/FbZW5Ff9nDtz7w2FfFPkQXCdCIqdZzqWNhhW9ibg7uTCJ+IjzRlazBuChj5eSAzTzeFXBPTR9wjFCnL2+J6Sva4cGZPdtz/eaXM90Fq20w1aOn0Xy7gkNptqY=
Received: from uranus.localdomain (5.18.103.226) by
 AM6PR08MB3351.eurprd08.prod.outlook.com (2603:10a6:209:48::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 8 Jun 2018 16:02:40 +0000
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C8F4C460756; Fri,  8 Jun 2018 19:02:35 +0300 (MSK)
Date: Fri, 8 Jun 2018 19:02:35 +0300
From: Cyrill Gorcunov <gorcunov@virtuozzo.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible
 processes
Message-ID: <20180608160235.GA2581@uranus>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [5.18.103.226]
X-ClientProxiedBy: HE1PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::17) To AM6PR08MB3351.eurprd08.prod.outlook.com
 (2603:10a6:209:48::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3351;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3351;3:dlJCL42PVw39V8jOU1+VJzXWpmzZ5pjAx4Fvm7WnYBL99FRfDgAwIksv+GDudg3gTkf4N+zZpsKiZ7yLj/OCYz0r8GAoNdaIBRLIwfa4lR76Oz2we6uj02ZzSKZEOgbRyY/00pbSxvymb7NnISWxMuwDNmMSTQPjC4005TOltdKf2z9dDzz0d/01PdUTqMVqzoNIzOz+zcrhe2/in73qV4/TxFphr0CBDwWFYdnsJZGSUJLF/IbocbDXzUjdZVQh;25:ysw7TByxg3yePlS4I7tfgSHSX+fCvu6LI391RDR9BV0O7KuvW+o2vv8WfeBEAaPLXQyvT76LBHvp5fSCD3MimV6q86i56eE/IsRniasTcgYKr3l6U9C1TXba6gorQfCEqS9H5I4KfA+VoWYmYKh/dgPI6B95hT+cFnzYgLVb3/EV2YnjnsAwMsrUtqHzGAgNIik6UJPtCZp7djJ7OnvtR6moNHiveJeIac/OnAgPCDGPRje0GvLIiTFMjVz6P4Zq3Epz4nBhVyXjZUXyEZ2PpOHytI2X3mkAiSMSqIC8nX48m/gw2Kv+N6pvdm0UQpdz7OIbGqWh/9BVCMuqeuB0Fg==;31:Gm1NmzuGLoioOoF3nRm5HJHxi5gghKG0CKp0L9vIuLcKmPwp8ah2T9lmatou0r/ftq5/e94sJzk9p2qllARjLc30zAT0PcN0EGBlUuwxUHNvfXfNF2T6pygNaSBaw9HXRohM74+/AxcQr8DZYwmDlmL5yld1CUpboOV0GS2SwgyFFtfrmPo4cVMwGTpif1dAuO9MjgPKX9q1x/2mmY/k1o6QvJ+OsiV1NBDJiBhaCSo=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3351:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=gorcunov@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3351;20:leV/95J1oK12xAOHUbg3gnppH/kmXOqsuVImBnEi0XdfdumpYo/dNYpNT6MTpgnnsuax4N/a/XEXtYH35zVD/jggRxpj2qVLcq1LydqfFdwJRHH2InIcJI1VAbQSTl2qiZKYKAYzjxXagrD9BODd6OoSvTEQ/rsYgVfVijBKzC7S3NvbDrBrpWnmLLzhq8SBT24Y2MYNPBRjkW0IXzgSvjEGw2r2bVycPztN7GknISETbMSBxFBQmcD44U8Lax9Np9loAe2VGxfvEUqlBl157+ZAmomRXemiZIoTnW55vUzIPcF4MXtsnnkpPPjH2fjs5HTYU9CZt/EqNuM392/JKyJMVgYlW8YkVNxfV9uXhaHtWEk2dUAcY3UR4qO0mwBvkWnVNvoHQRAVA3MDLP8etcCHRAjxwVie3pyi11ZXlky+TflybYa6w20+QoKbOaP8Ws66h0ZhlsTh5E/UT/Bow4cdoRAkXTpVBOyvYGByGcm8Z56yyLPLm0PqzR0y4pfs;4:U/2qqgm6uUFpiY31v1Nyj9JTm4VsgFoY+/MxS+INtEvRXlc48QZYTISf1g23dduxyHjRttAj9IL/0ib5WeAeFexmrte8yABwGyBZgDEcOtoDK4nsuWh+30Wfz1NciN+RKqRTTtTe0CtQ79uiBb4Z03nUxVQsycs4ALAR+NkER8M3RlAZ2cr1D9iZiRZtmZFLASsJsajh/ZHlgyiveUq7dVXepZyAoJiOVj8v47BLPq6MsEo9MvCfQEAFYdzCiNbckyRI57UixDntEwyPOgoNPA==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3351EF471585BAAD1DB1F822C27B0@AM6PR08MB3351.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3351;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3351;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39850400004)(396003)(366004)(189003)(199004)(5660300001)(229853002)(8936002)(71446004)(6636002)(316002)(53936002)(52116002)(16586007)(9686003)(186003)(386003)(59450400001)(6266002)(76176011)(33656002)(6246003)(26005)(33896004)(6862004)(52956003)(58126008)(2906002)(4326008)(54906003)(42186006)(97736004)(106356001)(90966002)(476003)(105586002)(305945005)(68736007)(7736002)(1076002)(37156001)(446003)(11346002)(486006)(8676002)(81156014)(122856001)(81166006)(478600001)(6116002)(33716001)(86362001)(47776003)(50466002)(3846002)(23726003)(66066001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3351;H:uranus.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3351;23:ZY9ER7SeS+DsQD7sfYhpl2t7UdjSrByen3ujW27pV?=
 =?us-ascii?Q?EXBDm0doDeXFtKrS44CuR0RVQwrxbya3iMyyGcyEJypWgQLnAL6GCFAmtmUL?=
 =?us-ascii?Q?OP2559qqki8xg00Ek75z91kEgNKAQMFRPwPnYNARUV4g5NUN9tieoN7nCtyT?=
 =?us-ascii?Q?YIBoDEYnlYKscpNACRqmq+ue29tA2F6vjh7yhv/6qFl3X+tdmjC2yFH0bgVL?=
 =?us-ascii?Q?nb/AGD40z3NRSvn7/wp+x72uQQ60uuYVDyGtwY0drmPtucPpUbOjhm2LdUok?=
 =?us-ascii?Q?ALo1UTAstnoezP5Rzq83Pc98n69kfS25K7anXFIAmHBrbncaVeFnGJJQ4iJ1?=
 =?us-ascii?Q?EqlQChFmYlHSvpkMwsbBNR0sLi1DX253TTurvOXI716BRPUIV1ZVGF8z1vhN?=
 =?us-ascii?Q?a+1e8bd7aDQH6zP2aIaCVSHNR0/JwKJgpAwALTJvFERe0R96S8U1bkWaj6lr?=
 =?us-ascii?Q?EBm6RnWGMIzqT3FQrqVOB3Q8zAZMJ+9+3KgndF0zqz/u455+F21cJVz8jeNA?=
 =?us-ascii?Q?eUedQJmmLkx7bIKFglY1tkThbaaUFfP6uFV1mabL1p6lrYJl4cpED/yWzpZ5?=
 =?us-ascii?Q?VPNyVJB8PyKDpTYZVjk3G34epV0gIXd2I5nPB/EAhCFKGr9s/A/7mqsbs+Qp?=
 =?us-ascii?Q?bF9l8xZEz4DR0kTM5hC1gqw+RXbhO7QXdrBm4doUJzGbYvQvnDY4Fipf74xs?=
 =?us-ascii?Q?199KoS2qx6hVlwbq5Ki3unfRHgml/9dkAmj+STD8s3TgaC9c9eO9qPuwknhF?=
 =?us-ascii?Q?/FPa9Td55dMWI1FHbFZL+8puIA1dQB+iupfpTxNDjE7hXiC6iQ96QmR3Q7si?=
 =?us-ascii?Q?N37G1yJRDRl4K6KkmPWOGZiCt5x7rOITIcKXWAEjZvrEgUjPFvDBkoYuNhl/?=
 =?us-ascii?Q?UjmL+TNOXmkzx5Ksb2g9Qpsiuwh96b8b/QXavFmyIpg6jhrpc/UHGDqDAKsa?=
 =?us-ascii?Q?XiFCgsiOWAkPtGEyfuJx8bAhXlIrulwTVN7RhPu/1iPTFCxx7pRBzUxXkpiu?=
 =?us-ascii?Q?hXzyxIZVn4jTmEbBeojI1/4/V84+CV+4aZmZ3vD6x3+i7BO8QutDnOfNUsmZ?=
 =?us-ascii?Q?KUaAO9HzIM7EwTcneFceIEpuMJB16EN9+p3OeiPq4j2SuHU+e+PEBFH/3IJg?=
 =?us-ascii?Q?40mVueY6SBWvLV26qNCeLYGMzDH6JEs7WdI6hV+XMEDfYx22w3LtL2ynph8e?=
 =?us-ascii?Q?yKcQmTB2t12d1QTI2O1Lhgtwf72NVE2s2W3qTkKrKSaxGM9qgpJrXVSWC4iB?=
 =?us-ascii?Q?3DvD1QQWjJDWZHKOM5keCN3dtmDR3OEny9886L6P0CK/+O95Cn68nePFul0H?=
 =?us-ascii?Q?5Jokx/N5lFKJN9+oOtBO8GW8zzvfvpLngJB8AF18C77rVMo1lnNpZSWDlcta?=
 =?us-ascii?Q?2MzWLLo9d3XwkQ74pgxsZE/tK4=3D?=
X-Microsoft-Antispam-Message-Info: lJb79n0WlDkSkIbedfPYTwuPvDHQbpiTGAp2jT+HmkUgTmvsdMNGWCPxJZfsMIlEU5QNVKeljE8moB7JPd8nv/Wqxz1H0rQI4w9Rdm4a1xKGSk5oEgHraOVL7ka+PJyBwM89wE+1WYbif8BcOxoBkk5FYg6go55FKQspEiy+8EubG20Gy2FyNuxtn7xlxKh4
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3351;6:BC1C5Fsl2qd4FRj6MW6mCaxpF1t9P8DdweQbGlA/OaSRjkZf7pSUZS6q2Sg0CNZMHxmi01xcbRhuPVQyEF1Bo65eE9xDNoil52k5EmI4+ULPjwNMJKMFBpHPLP3YMgUrfplvFgPdhUt9F9Vv0McWMOABnPdEVsNo5+D1ajjtID9WhFys/CJR3G6f7CmWgxvFtrqRbwyre70TM3CTTXkiGEwIZZ1HHOEZhg0maboHqVYJxY5vzxhkRZfocUBWUvX6mSBXT0uUhi8PfUZ/9NlMKhrDOZZh5MdxqFyIaaPFZuAB4nzkGl1pW5qV+cHAgbaICA64LNEfwujaYRjTeSx/L9LTtoAl6DtpCdJSLrjiNDUtU0pEoCvpEQ1v8RQ/2VKteDwPEzAfEgUPxbo8qm2yA/anW9d5bFRxrylzxVM3GXQbe1lwSKxfs5k+DyLG2kmVvG8JKEuqS0CB/1aQMRcg6g==;5:ii1vp/y4iIBBODZqWNZdr6RDo2QV4mqhHqL1QnvY8QSxOOj6CHC4HMQCDNBphDoNePbR+K9i1/SdE8ZwCjhLTuHuXT7lcJLk9vHKOzD4Dr+5t2Cd45aSCK0UDrR3tewm3L+AfaIxqn633UzIKB99GnfjNP+FAlDFRKjjDB8uXiI=;24:MWhGZWRVJsNZfpfc5ZhVN0VD/zAgRCsG6jQzyRujObmq/CqkH9W3eOe6gTnP9J6ECI8cWRIxY34LdsKQCX2oPpPzrE24rGNGA6MDOhomtrY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3351;7:ntLJkMVIaGFmeL7a0gyRBjzV38JrtiS5EIGMzl65BxHD47JcGvQhpJ1gr8PBQrNrhbcqytekElaSzbmAKWK0aT6o7sv1wn4tmefuWtQjhtb4SPzukYnmp5sryJ8LZQLlCQxB7OmgXMqjDa9+2N9Sv4xM0xuToKzbIR4rnLA1ROEkjf/SuRC/QBshpy9oV5ku/PeftrpN5tpUbIgXtrUMh/WSv/bXJeG8YYkaEOM685LwwXI68BmSwOryKK/HFxDH;20:+ZtyZLRWszhbGi5S29S+Gg3O+YD/iGSVMblUcyiT8hayj2BdtpnrXetIFjzMZhDKt33Ik1/wo/IVZJ4YzMPxmSP+4qNIoGNz+3H5yOqv5VIxGXlyTo3AmIttcd8b1FkSkbP7gbWBlF/Q7tcDaCmNYAFfA5WcXYpPo1UpbTmETiQ=
X-MS-Office365-Filtering-Correlation-Id: 6841f5c3-d79c-4c6d-b8db-08d5cd59436f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 16:02:40.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6841f5c3-d79c-4c6d-b8db-08d5cd59436f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 05:27:10PM +0300, Konstantin Khorenko wrote:
> The behavior has been changed after 9d5b86ac13c5 ("fs/locks: Remove fl_nspid
> and use fs-specific l_pid for remote locks")
> and now /proc/$PID/fdinfo/$FD does not show the info about the lock
> * if the flock owner process is dead and its pid has been already freed
> or
> * if the lock owner is not visible in current pidns.
> 
> CRIU uses this interface to store locks info during dump and thus can break
> on v4.13 and newer.

Indeed, it should cause problems with procfs parsing. We should add a test
for such scenarions, and since we're running tests by linux-next all the time
we would have this issue catched already.

The series looks ok to me, but I'm not flock expert so better wait for more
trustworthy opinion.

> 
> So let's show info about locks anyway in described cases (like it was before
> 9d5b86ac13c5), but show pid number saved in file_lock struct if we are in
> init_pid_ns (patch 1) or just zero otherwise (patch 2) like we do with SID.
