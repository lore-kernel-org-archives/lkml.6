Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF64C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723021019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="wstzMwNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeL2CPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:15:02 -0500
Received: from mail-eopbgr750091.outbound.protection.outlook.com ([40.107.75.91]:17717
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbeL2CPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21ZKh7GKCs26Zqr2ZkQEW3ipK/KpSB7TzWVw1IU04r0=;
 b=wstzMwNQgg4zObmgABDyrgIhFBWF5JLpunuOa4xHFUEES5fi8JVDAlWAlEmbxsDL+anChkxDz0gRV7HMl0FGq7kjQ826Xu4Y4kzkweRs5UvRflWZrCR+E486PWvvebrqmnj7SJ5OwJUXt5lYwgfa2hNswjH/nGJWyKBvAVFsVs0=
Received: from BL0PR0102CA0050.prod.exchangelabs.com (2603:10b6:208:25::27) by
 BN8PR01MB5522.prod.exchangelabs.com (2603:10b6:408:ba::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 02:12:03 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by BL0PR0102CA0050.outlook.office365.com
 (2603:10b6:208:25::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via Frontend
 Transport; Sat, 29 Dec 2018 02:12:02 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sat, 29 Dec 2018 02:12:01 +0000
Received: from callcc.thunk.org ([208.250.98.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBT2BvML006243
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Dec 2018 21:11:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 331747A4917; Fri, 28 Dec 2018 21:11:57 -0500 (EST)
Date:   Fri, 28 Dec 2018 21:11:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <lucho@ionkov.net>, <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, <ericvh@gmail.com>,
        <hpa@zytor.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, <rminnich@sandia.gov>,
        <v9fs-developer@lists.sourceforge.net>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
Message-ID: <20181229021157.GG5864@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net,
        libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>,
        ericvh@gmail.com, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
 <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
 <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(189003)(199004)(54094003)(316002)(93886005)(786003)(5660300001)(88552002)(6916009)(36906005)(106002)(54906003)(229853002)(16586007)(58126008)(2906002)(23726003)(103686004)(478600001)(75432002)(42186006)(50466002)(90966002)(7416002)(26826003)(33656002)(36756003)(305945005)(8936002)(11346002)(46406003)(476003)(39060400002)(126002)(76176011)(2616005)(86362001)(6246003)(8676002)(47776003)(4326008)(246002)(97756001)(186003)(336012)(52956003)(1076003)(356004)(106466001)(486006)(6266002)(26005)(446003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR01MB5522;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT024;1:vVIAWGuCNd0X9952LmC6DwzHzRPZVhGcpLJexqeY4fWkqq4++vKr4N4B9qmZvZRl1SJZjATiWgEQsB+rMrS8xcjnwn9yy/Am0UoE0ARfdaZTTWN56h2ehH7fZzJSEd+A
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a0fdb2-acf3-4053-8ef0-08d66d3305b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN8PR01MB5522;
X-Microsoft-Exchange-Diagnostics: 1;BN8PR01MB5522;3:BGmB2z9VGlfJhqQRvnQbuxBPXCf6YI0VvpmV0bnoUlfoJHildZW9dgMfwiuxmdapJ0Dt/5V64RyL9AcIbERmO9slru4GQRaOJ2hwLiIIp0QquYSc0Ht5pCbpErixz212g3JO1Uxxd1nvt5C2nTnwhTrQEy2eV2ihfeBS+xVS5NR6khbBv3qGSRbwHAv4JQsUU6pUmxgi05F6jcMW/aYDwkmd+aJABk2B/cEgGYoyf6VZKgCoh20M/1IvsXb7GiI1AXjxjxeWFCB67BHcOviBIvoejPnJuQRGdxo9/EmvFdEPfsFqkNvuMU3aXjffRxsGaNaC9ahIheDrs8HHVVtxuQ==;25:GlT4ZrdHiH4ZztGhgjl/uiuvoCviXRaEJwu5d97S3qY+ygSOxq/bvSTyHxzmVlFNdgASdcXNGUy96iiRf+wRXPo/r8+CZRdnWgtX0kIt8lXXxWcavgqnoBKOsKWP2SjRXM19Nadolqm1z5xlbvP7vjXZZZwjdxYxui84FZTFjViSGccRFDASUouUtzh9wJaXwRjVKhD0dYfDB+QXUh/v9OwDtMcywy2F286FKS/FbOyKTQRWCa7lyTqTZtQQbGAiwZIeeIEf8RPbJFD8MpQlZOClK0PNETU9sCpGB00OnHqGmmY90b3+ANR6rSdmPMn3DkPFtnNnb+rUmVsVbgXa7w==;31:jhrv+bciG0v1RZr1FEpqhY4Tg1Y9JVUQZq0ALtpR/VJaKD2ab2lvBIaKKUj55p4V0SMLmclVbJ7oubEzclOWkyudmxDCwBqeeI74mDqQgpErRxUGGAU3CP2FziHzeirS2CDZK70kFDuVRB99z3Zmqo31Acd8ER5KUiZF4afk/R5K7GlpTFFtntzoZ1WCoGAYbHh1fMHx2XZ+p1KXxaoZTbNcI2brtFdkkjNHWlscHyI=
X-MS-TrafficTypeDiagnostic: BN8PR01MB5522:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN8PR01MB5522;20:G+cNqgnLpMMbg8y1aFkQowzXIfvG1sgK7tjtGurDLmgH3JZNdWEYLO8cq4UQDigD7GzjsWS9V+e4qrVMA68V8jxeKQwvLP3DXygYuAtGilepnQu3Te0lc4ZtHlE15wijMVip9cqDewNlAQkKqhKcefe9f7kQkuwyn21ZxGsEmHL0AYP48f4nNHqGiDTybvyJCyu+7KAe0ql1eFxnl0+kKgeT4OOWEi6XJ02WNFfUPQqKpBqx3edSqzq/qXeRtgmSj/L5HDdOzPA+FtDple/5FIECo8JSSB0MCdFQBTiQWIlla1+DUgNx2NTam4KiUakToxoznlNOdz9RBsIxMc4s6ahioCw7q4hdxoqrJAHWpd5oliyJgxMGeFSLXL6Y/mvQj5GlPwL9QcnINBtxbxyDJ8aQN334ImmtiIKeAkKmeLiSBzJRuv1WJL1A0JLEeEnfkAaWX9ptOlggdZ2+ERqsjW3Zr4Z/OwRPqE66jRvdDTccNJr/oalcRcuKKNvFJ4mP;4:BzuT41iOCD98KcIqYuTsnSlw8QOxdJxgUnIF8eiMOLon+eYJ2nFPPGTZVlXwVm24Q3npMYDw+cXqGYGxqQfeO5RqK3q+n0XtKegp4znzIr8g5iBGqvNslSx5nWsgZXE6/lmW3rWLZJTbJFVDyAyvMTKdhH5eWy+ZHW22RUU8nqI+eRP4TJRr+JUp/CynU5YnXcc8IxaN5L9IF4A/J6FSMQ5eAv5g6BvnNuw+UaUjWUsdJMq29b7qlqeC9qP8fRGzLUg4AtP8Fx90GLoiBzLf9Q==
X-Microsoft-Antispam-PRVS: <BN8PR01MB5522D8EC2A1C8BE209991410B5B00@BN8PR01MB5522.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93004095)(3002001)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN8PR01MB5522;BCL:0;PCL:0;RULEID:;SRVR:BN8PR01MB5522;
X-Forefront-PRVS: 09011458FC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN8PR01MB5522;23:b+h1VlHzMGScSLRzix5PMt9Vl7n2/YSumZfHKdCqA?=
 =?us-ascii?Q?no81llJAdGDkNaoCgNjqUUpd6QQSMA/QHwyVLK/4IVlk71TYOaYW4BzaxFDl?=
 =?us-ascii?Q?VoTRZJFr2lqO/MLuqWgmDSHHHo5SRQYKkNnq0RTiHs3lNfPAQGN6enTG6fgV?=
 =?us-ascii?Q?+Zy7tfHqujxPa2xje8mWHjUzZbeW2urXJRTw4q6Z7NI4bHs64UMVvfarSV2t?=
 =?us-ascii?Q?AdsMgsmz/zy7O5R13ir4S2nxcfTC4Y1eGAy0oT3TH5EI1fWd0h7vXuBVi+Hw?=
 =?us-ascii?Q?bqcMGL0USezb8bWeF59Na7t/C/kpInszKgkEuJLGwfoFSasNOQTIVOffareo?=
 =?us-ascii?Q?bopMZPiJkARhpN0lhczb4nYLe9pbdGxBSJ8nyjxQ0asaEoR6vcFa454AtPQ3?=
 =?us-ascii?Q?kDPSIvkudQIRnzPZmimkra7Q8u5clbjfPGDDsjBUE5BC4+40nyXhZVG8xngl?=
 =?us-ascii?Q?sWBeE7AWhrlIEWnASg7TWvQI4JndGflzmCtjPQT1WvsYJ/mFYuxjC41CCCiQ?=
 =?us-ascii?Q?267rEqLeQZwjyimmlNcDvb88W67FHz59fCMPe3ssrc62oSxaVnIPnU3EgYgN?=
 =?us-ascii?Q?GlEPWpFr2I5aqdUW/AIel8FJDwTltgFMui37dx16pH5WtK87sxqDsUiDZCxP?=
 =?us-ascii?Q?AVh6K0IyPjfgH8LDv1atapVjFS1nTymKov19xr8qCmfkkSrBPyFofmYdR+hQ?=
 =?us-ascii?Q?jN01cVwQhgZx5TUMG3/Hkw+BVvOumOSCC7psLY8BPrzJj27YLg/ibGUfzGwv?=
 =?us-ascii?Q?0bEL8zVA74a28YB1wnp8CGF8wK09kfLZRPCbuAgpZpHpNKlepe9BC/hyHv3x?=
 =?us-ascii?Q?4HYVZSJTkIWQypbFmWgsC3rFW7EOjTuZnde1dpOWhW9QItejj/mSjPs2MCBF?=
 =?us-ascii?Q?Ac7rkJVzk/2naNSrI69xFjqeXtzKYKTGMSIgOKCwxx8Sefz0Ye3dY1jxZ/ww?=
 =?us-ascii?Q?w3/brrPoshz4w51QY/oyrbDrbhgaSIZJd0UInKJ0ysMlPaELDcYXZkyVFg1l?=
 =?us-ascii?Q?hdeItpZApQUy8QCqpn7gf7igrVSMaqqddhNwU+ftazOKGijQzykV7nvAFXtQ?=
 =?us-ascii?Q?lELA/bIqoqDb7pbfFfoGwa2DDkoqz8Q+ZbLMeR4g3+0jY5RKMhG9TBeK8hQX?=
 =?us-ascii?Q?OHUJIsMTbctGvRV0rLlFULlmxTJNxZ1FbzlC+ycnXaQMX0d3Q8FVE67NW+pM?=
 =?us-ascii?Q?BEi9fIFjKmUeAfeaal8gwCoVIKDcPFZ7SKxWcAbnFejkoGbT41UrEki4CX/+?=
 =?us-ascii?Q?dEWuMvkdeKSI7ALUfJdGmjgpXheoiwyqm6cQNHvY0Ju8f1bu6EHVSaAFLSK9?=
 =?us-ascii?Q?4I/B7+WWfjiKrVLkt4DGpXe4e2h0+KV6KtZ4jMBswRX?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CnKjRiiqMRBhJSkydCIq7WXCYskuE81sXNAsFqJX2RS3QE5sXLCXZb2ijWtnQXxWaV5EB3U+GhddDHQMDC2eFwlxr3wo4C1sFA9wa4ZNrjyfI+vUVaW8GgrHfnshb4WGqQqtkhzW/KtGKwFyWiEbSHUU/KIrAusNaDCRoValJbPpvw69hF85dhtghdX0yBgZZzrRkl4vih05HRgI2NpOE/kVoP92WhHl258P2G80wLKPVM2+PEVs1FdxhxfY2TA7qTvQ3ltMLthVjQ1JS5kQ9sCbE8I6h3kER2QFq3c1lsOyMf/eerpedGJIQdkUiktJ
X-Microsoft-Exchange-Diagnostics: 1;BN8PR01MB5522;6:PHbirM2QLad6SyYGeveW72ZrLNFmMfBFlPpX0sIprF5L8DkuJ2XmA4j9czXPLod6dm8luHKxLf7a605j/GK0ON9hPOBbH/p0jgb2Oma6bCdxJc5+LxybH2ldG09IWcWi46lmhDDEZg2p5W8d+EQHK9HBL82OoKgKKum+qF9piv1QuX5JQa3lagR657hQwHcoTqLXp86EJYUmpH2Tp2mfoJ9WMMsxa8F7jHvwySqfLpL9h3t6CZotzcTfKO7CMmFbubV9ruYNxGmlevOzisDceGmouKARk+l8gSGKv9iba+azwKv7tIAXOZvWi84gfYdfVm0591jgY4wSxfvKHByTg1nCxt25P309Nw+9s/87O2EVLSfE27LiG+Ocq/5gY0fm7KY0g4a61UQDROWAl3TE11cdtbU5WopGvr8Cit+Czrx+3gGNjS0zZV12gR8KLSnRSot/jvnDWO1oO8dYbT3P1w==;5:WdBRXXS90gJ2xjGiwMANb+/E5GbNodvS/2freFxWUQvcTtfy0pj+JTIFl/o2WX/6HDUWDDKeMs7tGIb/yOCKpFtQWiFk5CtU7XwGLHQ7jVjeYDy74gzRdfnF2p24eTNB10oSoafIGBoJgkcb7VtKpAkzkpVIg0PpDeS4ouwOrfw=;7:xhr7xNb3M9ON81UU9kaVVoCHJJwuewt/gXPqwSy4hA0mfBzgK6Z336LqP+jTF0rdu+xJRg+QQ5bCXpTuPpbzz/Hnwpj79XrCXZsFyQwM7f7lO6ZaqgIX1g6q5aBr8IWbImERFtjO8d9hDcwKu0zsCA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2018 02:12:01.8653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a0fdb2-acf3-4053-8ef0-08d66d3305b9
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5522
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:18:18AM +0000, Peter Maydell wrote:
> In general inodes and offsets start from 0 and work up --
> so almost all of the time they don't actually overflow.
> The problem with ext4 directory hash "offsets" is that they
> overflow all the time and immediately, so instead of "works
> unless you have a weird edge case" like all the other filesystems,h
> it's "never works".

Actually, XFS uses the inode number to encode the location of the
inode (it doesn't have a fixed inode table, so it's effectively the
block number shifted left by 3 or 4 bits, with the low bits indicating
the slot in the 4k block).  It has a hack to provide backwards
compatibility for 32-bit API's, but there is a similar, "oh, we're on
a non-paleolithic CPU, let's use the full 64-bits" sort of logic that
ext4 has.

> The problem is that there is no 32-bit API in some cases
> (unless I have misunderstood the kernel code) -- not all
> host architectures implement compat syscalls or allow them
> to be called from 64-bit processes or implement all the older
> syscall variants that had smaller offets. If there was a guaranteed
> "this syscall always exists and always gives me 32-bit offsets"
> we could use it.

Are there going to be cases where a process or a thread will sometimes
want the 64-bit interface, and sometimes want the 32-bit interface?
Or is it always going to be one or the other?  I wonder if we could
simply add a new flag to the process personality(2) flags.

> Yes, that has been suggested, but it seemed a bit dubious
> to bake in knowledge of ext4's internal implementation details.
> Can we rely on this as an ABI promise that will always work
> for all versions of all file systems going forwards?

Yeah, that seems dubious because I'm pretty sure there are other file
systems that may have their own 32/64-bit quirks.

						- Ted
