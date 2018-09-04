Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5577C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9202077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="AUrmzo6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9202077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIEBnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:43:47 -0400
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:14016
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbeIEBnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si2P4VFsFM9sWMsPHh9peEBQqNXIKAqkU42zdL0H6g0=;
 b=AUrmzo6jpV3H0dSsIBFV7b4oKNhLOIDsZW7SqVdOr8CJqTCMjWILQi1saOQoeqMmL2e7lLY5vJB0HAs2FIv00WpeepdHX/6uGrlJs8zBmepPmmqotQ/LW6Q/6nJ11A5MqSWvXe7nnhjlZuFfbG9Sfiy4a0mhGA4mfumbqeQ1YZY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4453.eurprd05.prod.outlook.com (2603:10a6:209:43::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 4 Sep 2018 21:16:48 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fxIgd-0004mV-Mi; Tue, 04 Sep 2018 15:16:35 -0600
Date:   Tue, 4 Sep 2018 15:16:35 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180904211635.GD335@mellanox.com>
References: <20180904174808.GS335@mellanox.com>
 <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: DM5PR2001CA0001.namprd20.prod.outlook.com
 (2603:10b6:4:16::11) To AM6PR05MB4453.eurprd05.prod.outlook.com
 (2603:10a6:209:43::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d8939d-2dad-4150-742b-08d612abba10
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4453;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;3:DNaylYibJWKeCClFAMpG0PmWvMQVKHLRvlvwP/XXOxkM2xCnM33FMSg8w9e2jNhKTY0K5/Eg0PpDI6wXvIBiq9sFy0aHmkGjP5tc0vff6Gth6/ZwECI8dZNSA9XrIzc/9JFaW/uU8KajwhPs073XQX+lSkk0Qxg08PIDHEmvcoI12tE/0rImyvdTf8WqcEQ4A2/zvRkDeMJuBrHNY+DemX/ePVImog/iVF1iIsFD9YO48zJyjIDKoxCFD1WYjGwH;25:2jOCxrg4nULLRJI9wV8O+hqKhBDaWUvJ3jatkIAxf0k5yaYeYQzPc1Lluv9USnC4fqeQtWUAnraRUxL4fwXYA/JVfCTz05W/XP3EwIFjMlW7i03ynfTnb81o3BZwAZbeaSRhHPlaRe90xY41hZxBQQbZMIVT5enqr+Rm0HmPLei2j8vS4gtCjbk9bHtxl24k/ORgVFO4mq2qNdftktLLrsEl5tGZUtpMIimxOmb9RoEtLpQOVbZqboaN9ZgMBnhXUVY3enGjjYta/veoIRe8G/N7m7Fafa+/Cyqf92HScs+40yu5vH5tt96sWLabocbH1RiQ2UmOMhggRoaQiVTVhA==;31:7FMLda38uhHmxUlpa0CfgprypQ/cInFDMJTaomPiHK3LDG1Ksc6P0jH8LWHcVKOLWzhof5Carf+V4QyYlS40wPzMUprBnCtRMynIl10pndlgGVI1E1g0wsAmjW5bNmFObnYpcHsER1FYUbUGEexwzXnSlETLtn/twpsOcq4a3LR0DmmOFQEX1joR8l2OtOMAy6ZHhFFp28f79JCwmdQkNGTvVwJpaiXaYpg2394XT8Q=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4453:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;20:s/AMQc4EupRk2nZrPsRRoGapnr+oE9+wDUP2QIylGsaolotrRsEZ9hKxyiMoCwV9vCX89BGlqB3oRrnIkpqwvfpJvn7d2MBAJh4XH90qZ5zKq8dHojAA+rxPxPebkktvrdjcde4j60D+ieN3lBE6RBx2pNoQOkqy2cYsc8mGt6jD9JKpVHW2whTtskboyCi4eitmRbwVEDQRxoRWMFHii9VEBX1L9GTs8GcW1K0knLGdINOjhMaO4gxswqRNbhI6iY+4iO21kO0lprYeSoLz4AWYbwd33H7Pvb8hYXJyNrm9RzBEDGinr2VdXstFVQ0sNetPD5QqCRjxTVYU+6RaJVsL9e8I22f+S4skUvT3O9mkp+TlUPrkjLQutsVU6pJQ4Ym3exFVi9ExZXNM4pv4Z7AsX69OUowUp67k+6C6PzB3d0A+m1H9LQpbAyeE9v1NezX+dyBNiiGb9lAQW+ZW0IKMv3OAdDf/QpSocvxlZ8A2IRZO9UoY5GcreWxskeSz;4:Wt3RC7Pl1184YupHmB/X3RA3mVp14noTF8Mu1KNyMCIAIqPPwcFeGRSmweTK21NrLhqp/HEcsdaXZh9mbzeCHlSWXNMAJgZcYYupcOePQgNgPi55kFp4Wtz6dKsWEW7OkLDXSXzCWcoXF/pE3VCQyukUSCJL1LbF7ctSTbRv1AUJJ5c3ULNc6FpI/FieKswnfIgZmwjoCsv4E+vD2Iatr2HovcCSQVS5BD1Lsj1prxvC3kjYtVNKNTI50bur+cgGbw2SKnGoOVdoaRMDph4fyQ==
X-Microsoft-Antispam-PRVS: <AM6PR05MB4453B37739B7186D1FC45217CF030@AM6PR05MB4453.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR05MB4453;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4453;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(52116002)(229853002)(50466002)(1411001)(76176011)(46656002)(66066001)(316002)(486006)(16586007)(97736004)(478600001)(53936002)(476003)(11346002)(47776003)(446003)(2616005)(86362001)(186003)(83796002)(105586002)(386003)(345774005)(69596002)(57986006)(5660300001)(305945005)(7736002)(3846002)(6916009)(6116002)(33656002)(106356001)(8676002)(8936002)(6246003)(58126008)(107886003)(39060400002)(81156014)(2906002)(9786002)(36756003)(1076002)(81166006)(122856001)(68736007)(23726003)(9746002)(54906003)(26005)(4326008)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4453;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4453;23:7YbuEUXSOTD5TW/R/TPvp/ISEeRwG679g6OIS9y5D?=
 =?us-ascii?Q?9a5r7d8pE0LBF8unnmvO+GekPJd2U2nJZDRotsb02l0RdiyW/ffK1+ITKb1u?=
 =?us-ascii?Q?hjo8ngIr+MEclWNyQHIlVTPSd/HeUdHcUmxUQl3dktj4dcrT6AfM7XDIkVjS?=
 =?us-ascii?Q?SOYqzY10ydx36k4m0JqeD7zbM5r5Ana+ui3oN2+zqevfQQ2W3pceDTej1VWe?=
 =?us-ascii?Q?9x9W6MNDBC8ndY6V9GEuINVCXU/5ads4FqZYL1JzolgW/EVKvciFEGiqFLps?=
 =?us-ascii?Q?uEpHWdv8Gz0EwkiZ8Zcm8S50rYUmh3rmkMy1+KBcYv4OTGOyXMR2c8ODARkV?=
 =?us-ascii?Q?OWBrCI/CqnaS8l9dVkty44gj0fXAIoN4bD8PiIpbpyH064XBzqlxL5Pawsat?=
 =?us-ascii?Q?MHbjZElPMv6hl8KS5LLbvpy12WOJBvEIt2XOE++myPgHkwEvWM7Cmx3AJtNz?=
 =?us-ascii?Q?lKIHwAQPQTb+o49fiOu+jUl3E4J4cvB7Wg0PUFBDjmithahK1nLYy67+WPwJ?=
 =?us-ascii?Q?JztUBi8NDNfxscimzLK4umiucK5ehy9Z4+aqhGsmkvA8q51NZjR3jAKxf4rc?=
 =?us-ascii?Q?ilwX9FqfnUcyizG38sYuQCm9mwof/Rzt+W9PciRVFIZpI2MgegdolFSu+AsK?=
 =?us-ascii?Q?rax1Ky0+xgye+VEeiKxiK3EevSW475fRYY3IVHiVpet9Q4w/uF6JLx3UXWnz?=
 =?us-ascii?Q?rgPR9z/uB0sVPVY/+iyEMhHaoJEUttg/gHZ9DQQeSFZZJnwZK9s1yQU4CTlV?=
 =?us-ascii?Q?UM/WHkD7p27Ga4ylw5Zu6bgFCCVjV5/d6dFV7/7WUOi+GerJXn6K0uKQop/g?=
 =?us-ascii?Q?8kBolW/+oaO8y7MLpcrk7zxWTki8iBKx5Dz3yxV9nW6l+Z0W2opj9RF+ZH59?=
 =?us-ascii?Q?F2K0DJFdxCwdjIBhUqfGeQWIrqpC61BdICL4WMjj8zzuL0nVqyK7dIViR20N?=
 =?us-ascii?Q?3kVWVtoRZ3dfMUFkJT9WINu19FxwcQF0TYgRlF7xiEd4E7PXPq2210d8CdSs?=
 =?us-ascii?Q?M+kimya1JU+HqEus+2xVxqNgB5sPEtG7nY4KgIkP5Up13bkpoy6uR9R42lwn?=
 =?us-ascii?Q?c1UDVDAwiogvCzIdrRbFAtq5uBljfuyjN0O8rysNmsM5jAarwQhaJVhujbv5?=
 =?us-ascii?Q?wY09a6eHuFsY7KbAk+rOOC27DnYGuIFCNkvwIeh5HbYaI7HGntGclocD4TcS?=
 =?us-ascii?Q?PzsiTsv6XcyNHmj15t9b+h8faYMtrnQJtse8e/cDm8RsUfRDifmV8phnYSk4?=
 =?us-ascii?Q?J3qrzYZ4Fj61XioolIqDL9gN81TBiO/+v6sNRzwcbuvJnKO+VnR3FFY0N0GL?=
 =?us-ascii?Q?AhM4ZjZXqBtioiY1Lfy/T2CipRA/pzk7bbNO1KnIQ1jD8hVz6Ci7gd3d4Qjr?=
 =?us-ascii?Q?5gFDj37TECuail0INYhbj8MHW0+2KopKtXFic9b8EJXzyQgin3Lrngo/IWlP?=
 =?us-ascii?Q?COOB5szgw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4ftBabqfzt07NVuwLgB72fNh6v/cqvs9LpfmBAsg/pjr5SJ8of1bmkkBdh1B0wYgIqhw68eRWCPrmybp85EuRTOcO4wqlhCVKKufOfdaklfHlN06SL+6RtabxL5y9GnefxZPUGpbUYp9bLTi5T/Bqk/4En0qk2udumYHnVZilE6yorQuj1jkjTFhOQUBKA3WjY1tuqIPef8+D92SCJ0a5RyeZylrI7dGbXnTFq4VA//eIllHd71CcusQAGmZREyCJJq0Wxc1TA7+xssDGWzcmcUc0DkaxVg5LpmN5Pki3C6GVTFk+fC5J/lScCWdO6PHO85laWOPfk30vfx188HFmWPdwD4NPbUEbQXRNaz5g9U=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;6:b/opErbJh39lwV3dmaVVaxcEbhet6rpZWlBrSlZVmMQrLpyiER/OXSm94ugv5Djlpim6PJG6KuDfxrKGKmLT33s0csvAiYCH1O/p6Bq1pvr3Z1HhrpXlmKCwlUxmVvA/hYsRjkjg+rSV0VrDG4ZdmlYqdib+wU7sjUHcy6dGU+s1GU2M3GZLv4pFDqwLHbAUPV52yvTe2w1kfroe+OIsE2ryO+593LjEw/SnKLeFYpZxFyHKB6lwy6QVGAgRzrQaN0mySlKD2f5to+On5etQoaH5BuRibM4198e7Wb2FXuJeqTTUeXbaFhU0dfMwaxgYTErY+GP5+MStDIFW6dy5cDy86iq2u+6S1BoOo+fcogqhPkSZg+9q66slXc07vUre7oJrcY24XmbHa/BMuaVd8bGJ/GFRnXPaqfPktS9vY9rWufeF7ztBLTISQxGf5yhcz+0KQlK47n/3tMJiQsGsdg==;5:4QesbG+tKjlRLDQ2kgcjuuEh5B2jbX6cxOpGfWiZFV5UJnNrl5mPoMs+WhYJAKcu+JOWgll0pGcdmMULFXmYJvVRc16PlDKpNTD1vd37apZrL3gT7cxb/zGjQldypEzPqkV37uZk0y/FxMp0yHf8mwNzt1oQWiPjQNdD6gmpX0M=;7:w+EwqdBz8O6AYJVl+XwkCj4cWl0TzTEhcyU4dYPfyWBC5BqG0nS5lNHLQ0fl/02OyaqQGt5xXmLxoMBPUUYm3prPvF6dNCh6HGfRSszTnMavlXvzOIB9fnz9Y+nLcFqdrpL6B5ZwkGwe3u+fdhE6wFVWU7irgg9GnnMJmAJSagnW1pPzFrlKR6w3Nm913vQRX46thC+ZWYtsf//eFe+pFmBPgTnKBhHr1kjGrFqvwjZRe6LZMNozsXloeiVQa0Hu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 21:16:48.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d8939d-2dad-4150-742b-08d612abba10
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:15:29AM +1000, Nicholas Piggin wrote:
> On Tue, 4 Sep 2018 11:48:08 -0600
> Jason Gunthorpe <jgg@mellanox.com> wrote:
> 
> > Hi Nicholas,
> > 
> > I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> > console..
> > 
> > Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> > providing hvc0, using options like:
> > 
> >         -nographic
> >         -chardev stdio,id=stdio,mux=on,signal=off
> >         -mon chardev=stdio
> > 	-device isa-serial,chardev=stdio
> >         -device virtio-serial-pci
> > 	-device virtconsole,chardev=stdio
> > 
> > I see the hvc0 console hang regularly, ie doing something like 'up
> > arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> > OK.
> > 
> > Any ideas? I'm not familiar with this code.. Thanks!
> 
> Yes I have had another report, I'm working on a fix. Sorry it has taken
> a while and thank you for the report.

Okay, let me know when you have a fix and I will be able to test it
for you!

Thanks,
Jason
