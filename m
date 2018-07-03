Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7926C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B81E24899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="szcMMf0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B81E24899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbeGCHHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:07:33 -0400
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:18880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753671AbeGCHHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E6m8Uwe4NQkvsy90EMW0Pw5GNrq2AvgxvylnXQIeh0=;
 b=szcMMf0fCVDDGha750n/GLlEBIQzdld+0hrulZyrudPySnLOIb4lvD19NqwYFtm55wpBEYZ1qAbnxTdqu7iGdukhPFiuuhzttnhw4364PUJQgZOcky4FNL7MHK5w7dmiX4IiEq17xEz5PLT83qAk22lbwV2NjXCEDtnDQy8B/vA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Tue, 3 Jul
 2018 07:07:27 +0000
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180614122146.62118-1-christian.koenig@amd.com>
 <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
 <064ebaf7-8953-fd29-a688-26a5646111a0@gmail.com>
 <20180702134957.GA43045@bhelgaas-glaptop.roam.corp.google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91cdb8b2-ac72-f62d-2dcf-1c53d6d3a005@amd.com>
Date:   Tue, 3 Jul 2018 09:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702134957.GA43045@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::30) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33e18afa-2b8d-45f9-5159-08d5e0b3a365
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:vrBXR2tc64afuVWWCY7XMiEyJayBzN3/9LG/ynU+4+y5cTxSaCEYyCdayaJ+OKkEX6Ufsc4WwCHGICKGeH7ld7ArzwAktfITZK8+bwZXZnTPydWbcB2SpzfyPz0Z3RqbarijqfhpVdtphOd/RtnMz1hyKOIcKN90wwIPCLdRgDsacuMWgAC6Z98jZqVlaRABo6rk7WswSZifM68yy609m1v+YitktB6l40pRpfqV/47vxG+qTvo2O6ahAHv90PJs;25:CuyPaGAgQgbsyDp6XiwcF8ZBOCr4NG1EC/V8CWfC+yRvQ60CY7hY0Nt2Eiexo31YUjJgxpG/ZkRvUGCZ2Ws9nOUsX5bE8yebJKgx5jGVDk2/ynaeC0gZRoZIVCp+UHH6SvU/zW1LbCN/uZtzFtNrYSl1trgL9pBDZj3xGY6fdaINkdAvclFQRVuxrdd/863k0fuyrhdBsgIfIkr9OS0d5+JtvXV8KdgZR8pc4ls0RJ0yFS+JLTYM5P7QSQ9BUuVQpu7EYh2Nv0NBQNc77m/zfZ2DK6m5XZ+CFIfbsnFclWydlOBxQG8oXzytB+JuAahzZqdGXn0SKydLgZqsjxNVQg==;31:6fySn4YVt1WbXTKvJmPKG32tCA/XiBwrP1r+azePuuEVlRE+OwxPMiZew30zN4yExtez38eT9zbgzFFU5T8XbdqwMTkiNQ7BS0YOzX0HrDfVNg8+L7ciywniTtPSZHOvf4YEcmiKPxxLxmKrwvIeVQPUB2viQXlNMANG0sjzyFNGAH8RB+rucx45G5hki4at7qMhp4tDvGj1e3HLDyJBM5rkCb/iWBVd4cr1K37a9n4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:qUw2oFQ1HP9+lNTvvOS8yOOjE4ZXcVE4bZHvdo9MIAVixc5dcw/f+BDW/LZSfXFBepiYIvLX9QqMUqjRQ6xNwBKkGwCEblF3FqQmbqOV73ikgd/ItWQHxFedjBT/cjp+S724BMMX4EbQ5qBFhj0r9b4lvoPUu3GuO4uSZDR8NrrEVeOl+K9py3b0itoo9BVP2S4VvIr6Wj9uOjm9LS+/gPwStXtDnOktUH6YGvCk73ZzW0vY6iEzf2iUNsya2pb8PS3H1TVwBOB9bd8e5RxPVhXUqdaVbYI8SRanZYXaGoBBoXGrT0gckAEpcIXHpmSNrld1OWxe15vPheiD1BokVKOXPl+Luu0/2E3q1jql/IZM7Kgrc9DPzfvwwALKgxhWlkP1BQcJm2eFXLuCr3HKM8lFLpqu+f0snlKw0qwWFHiQwyodvYUnXV/n22rl3/CEmqWgjh2BkEmvlNV/s/obANESQt5DXf+5BRAfxoTW3hK9Stuu5jHCoWBhkxQitQac;4:IaCDlI3Y/YOKFcYAsv3KOen1OQEoJoVIKABMq4MVbgn48428zV2I2FRk5BtiaLx2wYiHTM0FFhymVtpebsmWQ0FADZFhGMlyAsYlhQB3mE29zDdxXLWdZDym5vMcnuutCGIfsdiI1O3wDuxZFeNCqRFxfF7atMqJW6s/VDbbV5X3tAOPaWvLYYDSlcBjaF7Lemb0aM7MqI2g9NoYKL1AwjN6ZxKuZoqA4cwwjxz3KSihMaLewT5E/1tUTHnbVMaIdkef+R3RY1gJT5wSoJWWiYa0bPnnU6k5SRmUqoeW1n3XhdskKIwlnO4HC/4mRG8ueYJ60ep9PIGpbYxqTYePfw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17143001E5B650EE229976BE83420@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(51914003)(72206003)(6916009)(47776003)(6306002)(478600001)(65956001)(50466002)(966005)(2870700001)(31696002)(2906002)(86362001)(68736007)(5660300001)(6666003)(4326008)(64126003)(65826007)(25786009)(65806001)(97736004)(53936002)(67846002)(6246003)(386003)(14444005)(186003)(16526019)(36756003)(2486003)(52146003)(8676002)(7736002)(52396003)(23676004)(8936002)(76176011)(305945005)(52116002)(46003)(105586002)(486006)(31686004)(446003)(2616005)(11346002)(476003)(106356001)(93886005)(6486002)(58126008)(1706002)(229853002)(6116002)(316002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOkV2TXhmZ3dURkFEK0M4akhURXo5SWhVQzly?=
 =?utf-8?B?dmJHRXhSRVNOek1ESW55UjhTWGNDRk1wRmNLU2ZPeGF4RGtrK1ZYV0RQS1RD?=
 =?utf-8?B?N2EzblJhcm9HamFuVFpaUlc2VFpaREZqSExXZ0ROd3JPRUlBTnorUGpGb0xK?=
 =?utf-8?B?am10VkZaUzl1T1FMMGNYT2FPSlU5SjR3eTlyRjFObm1MOVFRWE54anpKUUdF?=
 =?utf-8?B?NVd6dkRjcDhmYkdTVFBBcUhnd1NrOVdIODhScGFCL25icGdwK0xlczNaN0xp?=
 =?utf-8?B?a3BYU3E1b3Npc2hJWVNxY3p0Y2F3MDVJcDROSzFWVy9iL2FOTzZ1cm9PckxB?=
 =?utf-8?B?Y1hTSUY5QU1qdTVTQ0ZLQmNhZTI5NWIzaVpHV2pkSFVXUmhzZEJOOUhhNGg3?=
 =?utf-8?B?bW02aVlkWEwvUUVVaUp5M3BlcjFSZS9jL0FGN0dwaFNFUURnZWp0WnNQUFhO?=
 =?utf-8?B?MnVUWTUvSU11KzJBTXgzNzJka3lvT0hqVithaTBoZzVLZkxKdE1BeXpYcWNK?=
 =?utf-8?B?K1JUaGlZdHozcEhYRXNZbzFLUWlhZ2IwUDJIMWZ2QU93VG5KNU9hdXJvTlBv?=
 =?utf-8?B?emFJZEovRk16VThOU1k3SWsxMTN4U1VubXM2a0VscE1LdWJrNGVDSUtiTUhR?=
 =?utf-8?B?Q2ZtZ0sveUE1T2QxblpUNHB5Ty9sMXFESGVVVWVTUUgyNXlxZ2RjQjRMNFJF?=
 =?utf-8?B?RkVuNGxDZXVQL3d0aFdLdERMVW1hR0JkQUNWeEFFeHRDd2RXWkY4dmxNdjg4?=
 =?utf-8?B?RVBBUUF4akd4bjJWVUp1QS81VGFTWXhybFJBaHJjWmRpRHFkeUI2Z3FBekpl?=
 =?utf-8?B?eXpteE5pTzFIWks1bWlPU3NhNXZVSzYzempuSzl3Z1p1bWhXUnA3VmJ2K2tv?=
 =?utf-8?B?R3ZwVnR4dU9zdkQ2ci9zb2VObitmNU42czQ4RUpkckpiTVNDZnMzcGw4STdm?=
 =?utf-8?B?dnB6UmdhTkZQYmtnSFptTC9Cazc1RER6R3A0R0szSEUvaDgxRElRcE5YQllH?=
 =?utf-8?B?YXlOMGpHSDl3Y0lzdjhoQmZGUFQrWmcyRVorZ1AxeHVSYVhoMFo0ZFkveHR4?=
 =?utf-8?B?em15bUlITGZpZXZFbElmdmdSa094eWlsV2orYmd6MEowdlFHOVJiK2c1MmpJ?=
 =?utf-8?B?VUVQL3dQbTlGVkVIYnJoazVZQnZERnZ0Y3NsUFRIRGdweVJ5Z2gydzVid2Jz?=
 =?utf-8?B?azFRblRHc0VvSWtlTERob1phVVhDSktybzV3VXpNMENPMUNPaXcrdGJSdkpi?=
 =?utf-8?B?dmRmWkpWU0ZjZ1hNZGExQUYyZWFsSmt2Qk91YUlPYlRmZDdmNDNLUzkzaklm?=
 =?utf-8?B?MHJRVFdDZVozUjVNNEJhZC82SGo2cVM0Y2JYbWhNVXdaYVdLaXU3Z3NOanpS?=
 =?utf-8?B?QjVzRDBXdFl3R0JabXhWcDdpcG9LbnJ4d3g4aGhnd3g1bWhvaUhRQ2VUVG9t?=
 =?utf-8?B?aTdzOHl3Qk5EbjZIbVJ5ektCbUJEVW94NkdLb1RCZW1NMlJMMkdhS0RycTY5?=
 =?utf-8?B?RURDZVdROFlINGc2T3Exc21nVFlXZG1zQUk0aWtnaTFhZzdod2tkcHRnbzBY?=
 =?utf-8?B?cnRKdkdBcVFPbklTaEVJaEY3UTZFYXFMZjU2ZTBXYUZLZVVadmhMc2NsMEkz?=
 =?utf-8?B?dlR3b05YUWsxZ1o1QjB4TE5zVEc1TDdCaFQ1YlNhdEdiOXY4YjR6VEFQdzNV?=
 =?utf-8?B?VFloWHRVa21EZENOYUhiK0FoNnJHcWxzS2w1Rk90cGl3MGNVSTZXbXQ0UFJB?=
 =?utf-8?B?dlRGMzNyZkZkVnF6UG9qdzI2WWlOemhEbnhKRngzMUxOSkg3N05PK1ZycXZ4?=
 =?utf-8?B?TkhnNlptdmVkVXZNL2xYa3ZXVTExU2ZiSU1KVnMzZkEzcmN1WGVDVkRXU0Rx?=
 =?utf-8?B?R1FwTm94Q0M0aEFhaUxqTmcyRGtwb2dMSXc1VExBa040U3RqalRiakpiRHdD?=
 =?utf-8?Q?DAidlCWdIw/1cKCL/wBkE6TSvAkUZQ=3D?=
X-Microsoft-Antispam-Message-Info: UADXOlMSmi1OwZ8f0DwYQ+ifD6m016TRQyJEbnPr0NuYZfOvzddkCHVodBH3Wpqy24Wg+sj0f09nku+x6VsHVR86yNI6f3UobgJAi7uu2DPQfTdmKPXJPFApim07qa/y3KcVnJp2HUJW/QYsQk4e6BBUz2JMRiGkLbaJdyfRm79C3SZYo301Rvj/K4FZKm/LVExJnlmtcHcOwegEMEhztUykAMvpc12FGqybiEN3QNanlBZDq78JU8wp4umPPT8ZQKUz5QjoxcgNMT50K7a76fwwaatGleQ8xIHsVh5X4pms/iSH0pUbkhVacejTGMFcDgdcXf+y8GmdsGlNOa/w/6bNWFyNw/i1eQ9sWSOph78=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:fYeI7mMm0OlIKgz4NzJLMBnXIANhpZHQREYI6R22IIidsH/c8EgFnerF09foXeVPuwJNhpzSh7bBmTWpnyyz6JtU8OCZx25IdKJiJH3cU5+vdFzKwsMqk3L9iyhygDpFAxpLrSv/zlBkOkpELjitS5lJMik/P2INYb1xHXYW3udifBnTTcfgAOUOpdcvoww5RSLl5NJ79KIozdUv5XkmGYuLblxP+UCCTw5hbC0tQ9QRS2GgyTxJ6K+I0wOxLT+HZ7Z2Uk/TyKKY27Q8sjgpN05N3XEO8+FAZyxP+BtS/jR40V+snysDmtDueEyRwJwZSZLJcRFLj7S3lLIg1oYyODO46AveWgjXOCnXIlUfBZA6Jy1dmgRUIE35pM5pU8+3zcxjp9XV8wlw0d4fHskkOYdwsX8f1xRaulTCeLWl/uQiYXx5nr8VxHUfHHcdWD+UT/szCq3emYJIXIgMjvA50w==;5:jQQjjBsO/X7pYr1vbbwKIqkDpeYn+bNQO9OqbB7bR4PzjkbXXzcq3yh/ql9U9lnQNUWfgPBgTNBdbn+3s86R6Me9G/xhUdXVF7EXx2YFC/syNb134NiAA/HHZFs+Lp3Ha75URqzoxODvfRK8eTOgQQt/obOAAXgLc0A2I9ZEg/o=;24:vKvZMP033SWlFhJeTZlNMRUL7hD14gT3V9LBUwx96ymzippnXLdb+syWiTkhND1e5HUk2m0EHOrnq4yIuOn2vkwqWFlTV+dOZ0uh8kpbtHk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:rZdHcbOCtJJIHVe72cqsPeWOg6H/0x//A5ZsqkZ7fVvfERRC4/1lDPYP95lJXtF50Smc5uf+/LjF+GEfegtTT3mviP8jQ/jtrSRE8b0HqNwhBwV0pLPXliRRgx+CvWjM3dptewCKb/wZSxU6CSmGfvW7X0Wb5WtVyHnydDW3gMCtxtzp/7zAt33/lCmTkDo49eUWfBadsYi7WfdTGpAMsoWdo4MA3mPOl13NejV2R8kOzbJ0JKH/StyVYiRQvaxD;20:pqG0+21N6nTZ8CX2k2IaMY3asKkv+xBdMZrO4ChL//VIHFko54vjccoFjHOGU7ZTaxh7JGCifWx7/Jrttx5mXrG81TPaH1w2FznfMFGRfItOOsak/iHek5cPfgnYfOenZQXeHMKwMFlvVF+SNx34NP77gVCGBI5t1yYUYHCbTweHikUoTNboO1OFZjsyqoYyxxI0HxrWvU/oNXVuSDBLmHk1ltJNe0kl1bWqLSeVJO30zyOLwRbQm+RRhkQVCO8+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 07:07:27.9620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e18afa-2b8d-45f9-5159-08d5e0b3a365
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.2018 um 15:49 schrieb Bjorn Helgaas:
> On Mon, Jul 02, 2018 at 03:20:59PM +0200, Christian König wrote:
>> Am 30.06.2018 um 02:57 schrieb Bjorn Helgaas:
>>> On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
>>>> Resize BARs after resume to the expected size again.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
>>>> CC: stable@vger.kernel.org      # v4.15+
>>> I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
>>> have them in v4.18, but since it's not a regression and the problem has
>>> been there since v4.15, I'm not sure I could justify it.
>> Well it is a regression. The change to enable this in the upstream driver
>> was added in 4.16, but a good bunch of people also compile our backported
>> DKMS module.
>>
>> And now those people are complaining that the driver stopped working after
>> resume in 4.15 with the DKMS module and with 4.16 with the upstream module.
>>
>> Alternatively I can disable resizing from the driver from kernels older than
>> v4.19.
> Feel free to help justify including this in v4.18 by providing the
> details of the regression and the relevant commits.  If this is
> something that worked in v4.17, and some commit we merged for
> v4.18-rc1 broke it, it would be a slam dunk to include the fix for
> v4.18.  I took a quick look through the commits we added in v4.18-rc1
> but didn't see anything obvious.
>
> Obviously, putting a fix in v4.18 doesn't help the people running
> v4.15 or v4.16.  The stable backports *will* help with that, and we
> already have the tag for that.
>
> The current trajectory we're on is that these are headed for
> v4.19-rc1, and soon after they appear there, they will be backported
> to the v4.15-v4.18 stable kernels.

Ah! Thanks for the explanation on how fixes flow into stable kernels and 
you are right it's indeed not a regression in 4.18.

In this case everything is fine and the backports to stable kernels 
should handle that.

Thanks,
Christian.

>
> Bjorn
>
>>>> ---
>>>>    drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index bd6f156dc3cf..d4685090378b 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>>>>    	}
>>>>    }
>>>> +static void pci_restore_rebar_state(struct pci_dev *pdev)
>>>> +{
>>>> +	unsigned int pos, nbars, i;
>>>> +	u32 ctrl;
>>>> +
>>>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>>>> +	if (!pos)
>>>> +		return;
>>>> +
>>>> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>>>> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
>>>> +		    PCI_REBAR_CTRL_NBAR_SHIFT;
>>>> +
>>>> +	for (i = 0; i < nbars; i++, pos += 8) {
>>>> +		struct resource *res;
>>>> +		int bar_idx, size;
>>>> +
>>>> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>>>> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
>>>> +		res = pdev->resource + bar_idx;
>>>> +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
>>>> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>>>> +		ctrl |= size << 8;
>>>> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
>>>> +	}
>>>> +}
>>>> +
>>>>    /**
>>>>     * pci_restore_state - Restore the saved state of a PCI device
>>>>     * @dev: - PCI device that we're dealing with
>>>> @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>    	pci_restore_pri_state(dev);
>>>>    	pci_restore_ats_state(dev);
>>>>    	pci_restore_vc_state(dev);
>>>> +	pci_restore_rebar_state(dev);
>>>>    	pci_cleanup_aer_error_status_regs(dev);
>>>> -- 
>>>> 2.14.1
>>>>

