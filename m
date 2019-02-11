Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA607C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF38218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="j5W8Ix7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBKNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:02:50 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:24752
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbfBKNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxU/Yvi6QZG+fBBf23C7Aipm0YvrkxJQz/RnjlybORc=;
 b=j5W8Ix7tg+kwj70TxjlFynbCWKdkDlfNieiqINvRSH9L5jG3XlkrrXRponxeUdJrJA77UjQZI5fA4yXK07yELJEIZNa4neQUMHasShnVdgHx8hsC4Z1c7hBoCf1TgdzADhfVZnpHQMhCOskObIG3/iDzniA8xYnv1o8elkBNFeE=
Received: from AM5PR0601CA0029.eurprd06.prod.outlook.com
 (2603:10a6:203:68::15) by VI1PR0601MB2159.eurprd06.prod.outlook.com
 (2603:10a6:800:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 13:02:44 +0000
Received: from HE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::202) by AM5PR0601CA0029.outlook.office365.com
 (2603:10a6:203:68::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 13:02:44 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; axentia.se; dkim=none (message not signed)
 header.d=none;axentia.se; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT060.mail.protection.outlook.com (10.152.11.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 13:02:44 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 14:02:12 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 14:02:11 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Rosin <peda@axentia.se>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Date:   Mon, 11 Feb 2019 14:02:12 +0100
Message-ID: <7790979.IuqCBRmgNN@pcbe13614>
In-Reply-To: <d406a2ea-9d37-3eca-d975-818a22ca2458@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-2-federico.vaga@cern.ch> <d406a2ea-9d37-3eca-d975-818a22ca2458@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(189003)(199004)(6916009)(426003)(6246003)(76176011)(3450700001)(4326008)(14444005)(33896004)(316002)(26005)(9686003)(229853002)(16526019)(786003)(186003)(356004)(46406003)(33716001)(2906002)(53546011)(43066004)(50466002)(54906003)(486006)(7736002)(106002)(8936002)(305945005)(7636002)(86362001)(74482002)(9576002)(126002)(44832011)(336012)(230700001)(8676002)(47776003)(6116002)(246002)(11346002)(446003)(97756001)(478600001)(106466001)(23726003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0601MB2159;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b12d0dcf-3f71-49a1-15fd-08d6902136a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:VI1PR0601MB2159;
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2159:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0601MB2159;20:TuEo+n0pmklO8zv9TaN7GMr9c2emb77sLFuufE2fPE7HBZrFiZ2Ev0c0UrpVDyo8WCs2pAmPlG+OKlMIOCEB1cCXU/zfGMqWOyBGecVO+sacC+c3aC+zlcvFED5vsRip80/u7Hn/vbVWomv1VCiZEt3bkLH3mgA2H7QNhzS5ItQGX76lvxb6bRfxG4YENLjF5XxQZ12/6dVt1Ann1j+FvmgT8giuIVX98kfxdYmZeBIHXq4J/iT+T2cgGgC2zNvYqELrYVhbEnH0dwgwNcRr6Ox5eDrdQY7wGM3pXT2qm/FWcVq9DLiMo4bN53lEPeqX8ifirFKQvvSXDo5ANOCqs5OY1N+itGmjbd8vDcGhwCiFns9OgH3JjnuOKKV7v6/eS1RNqw7vcsAls5GtJvJBd6Rq1BMWxN482JTCyrCZtYuGzs6mqG7wbbt6GCBRqom1mzyM8eRO8em9JNJOqPyNV3AdduVjmfA6+FJAWN5+kAuoVqxKPeP2EhfZ2ufgpEdg;4:nKJ8bVbEdIpzvHAKqbMLXPBszrauR/ExT4F0ShRBI6Ii7ZtcC4rMjrECfwOBxnsfRY7LgchuaHGMx1T2ZWoOBHghwQ4/6KiStDhGs7M7TJafzq3cFrgLEincVR6GB3aaq+/PNQEZFrmBnyctcfZ6+Ft/RClcJGPK6EV3TDzmgI2yqMXzFnZePm6ZuIv6GQefiF1qbefXkXPZGN5d5dI2A2n1bW4XWVu+82N9vjm12Sv/l+nJsqn8FrGTy6S8IYz0zuYRk8x0w+xp1ElhgLy68qgBk1Qsk4P/1ka+4v4wzlE=
X-Microsoft-Antispam-PRVS: <VI1PR0601MB2159C773FF9AE1B5EC649AA8EF640@VI1PR0601MB2159.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0601MB2159;23:M+TrV8mXJ8YYYkIZF4EaYB7kpFF6WlqfhBoKb5G?=
 =?us-ascii?Q?F2MJKqMaolKm5PgDTGXlBwKAASfRDaiN7fNMCraagKVFzvEZbURiOw1F+6Bt?=
 =?us-ascii?Q?+7eW79Vu/a48mUT05cJ4VWw9Shq1iYl3Ky0jFtjr7Ls3Oevajr4yegKAZAdb?=
 =?us-ascii?Q?Zb5J/+WV081DAYrXbPrP9N0V4UixAPTioF5JFPWsI5s3/ITleRXGynfF2YTn?=
 =?us-ascii?Q?EZ5ADf33SVTrj/ti/l9/PVjj7EXG/aTtXkeyi70wwamVwaX8INgX5nMVDcTX?=
 =?us-ascii?Q?HQ2+s503jVU5wWmvXwIDCEp7KZM66wQi3EZ6gRuOobKyFHt6Fs8ZfvNeiSIk?=
 =?us-ascii?Q?D8xYSp2V3NkZPAJylEy0VLnQ2iCgjzn2Ev+DVY09Ak0qRHuNARz+H6fXLum5?=
 =?us-ascii?Q?2gDuJZtjWxxVa2LJMFqNk8o4T+/5+S7JwbENPIg3BYKfFptbtxrOwCQ3dj1l?=
 =?us-ascii?Q?eThqz0TuGO0J8GW6VR9HXRCz7kKrncBaFgWusBM1Uj0EPA2AeIBtOq20Ript?=
 =?us-ascii?Q?+k81vZXXo+ARAlxrfwowCo+JE61Xctou5eK7JnHf5jTMwC0AvM0fTNVf6hHo?=
 =?us-ascii?Q?LpVqJOrfulFotYHmbRXkhpDvG1LikZFJ4DRX55343v83X0mhNgZeliWeAN3h?=
 =?us-ascii?Q?OVDIBPba/HhabYDfT/L2Xpgvi4Ouc2WfPoBdNSVQKgsrifyiPNNKm+7CzYaa?=
 =?us-ascii?Q?8Ppp8dhuabf1R3sbrFd0veTKay6IPwik6bUi2lORl7FYg9ifAVvX0a/pcP9t?=
 =?us-ascii?Q?jh7zAc8E3r+LkE+TwQeKD17cr5lIkge1DZE/UfgVoNM+TS663pqIHYWvTUgb?=
 =?us-ascii?Q?3Yi35utMrfP6D4M5CrmeadyFf6z88jTNzEh+ZGoBIF/WTnQMeMJvawm8RLVb?=
 =?us-ascii?Q?MTRXnhjJrPV+JoEbePjj8LfeUicxXBmBjA3EuN6UZ0c2KWmefyPofw3TSUzK?=
 =?us-ascii?Q?yoit/MS3sKGvupa8BwcNaENps+Q5sUG9Q65Y3B/df4CtdpR7K2yQgo80hMhx?=
 =?us-ascii?Q?1xllVuyven8kPdjI3sGR38uZD3+xbwR/sl9A7/ImindiCccm5pPMf/hISde2?=
 =?us-ascii?Q?alES2wpbdkfsLpqFuAlopKSD4RnwTkzEqFzZ2x0U4HdzhC5OVhnCD/BCxzJP?=
 =?us-ascii?Q?9hr2qYcu2FaA8ZmtPRhApUzzVe4dcUZL0+/0vcOgotip11tsRK8FRLNa5Z73?=
 =?us-ascii?Q?DWcE2hE3VNMntbiw=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: V4Z1ogf+yKoUiM4zbRzeShmb/7gnuHroBSuKhYNqhYZer55WAi1Uw52lHhT46eg7T9PDhvd8bJAwwNOl9TFNOzFF0ix2cYAKswhkwyJF54KLXRz1m503sM+MFsahVmqY6+LcalngrD8KYR9IJylX5aVq7zjGVa4nrf76O2MerXsboCferEuWRW8e63zpJAgIEC10lMqKrZP6ovRVkRdgJD3R02zIpHygYgdC7kbUHANTen/Km15m9j+tLBgnUHp6MqZDW7EaoSRxVyzvX85/Je20f4XD/k4tQ2gqysq1furjvhcnk04kQxyxfxCvqsJEcKMZdnjRK9MaZeKYhQMMJJjnKwXfxYD4bsICWm9YhqL6xDx+7IpzS5vqH7y25WJGCM9lHfRzRn3jpYR5fhXPyi0/dN2ua0v8HVVwT6e6Wck=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0601MB2159;6:FeuohWbOrVFr+lskTaQZyAaElMUNxLq8FTslD/e1uq+i4KJu3oGbZox1nLiW7oyyPQyS5kOFz8RoNfNqinuCvNZqOZ+G64sExzOQfhXdH0xC10ofImjDk6YEl983tGaulKrKP0Wk8Wfi7tGLzW6mK57mVS8a9zKKgEwrUpEF/KrODulW0YzI7PyGljogMs8Ai/ioBYwYMq1ByD2G7pdQXMyZorcxA4W9Aj3iJzmDzeWPvzhCunDcJI/Tu/jlxj9oeH9QO3GJF80R6p5EDxZLu0GSsHvdc5ulY/sITwXrm7vN9iS6qNK50aSXTIiM28vZTys0P+9zUHerZV8zK3/tTeKkEmFtfBCZ/D4xNKEo0LjSo0FA9VycYXhwZk/G7q88E4lHeAXScJxIOw0SABvDI+RNHoC07wxwAlvqLWvTzg0oGa2IHoF/MUt3VLSNax0iHRIYpvCdeeDKcSQjylDVVg==;5:bqBs7ZubLEEGa0k8UvocMDk+8wDmtuLjESm08nxgWJdIFhYusa11w+Y/MQFv8lqI6tD0CoTQB4slyCUn2NRRB0SQkLUwrP/7Y/IQVFWDNy0NhTf2MB9R8EtIQbm4ErWwiCVCF/wU7w9DLnJTdPfF/WwofoVxm9DL5H6KiLli5PMG4UPMYwyoWY9Jm7/yoqZZiHvLy4MvEpNYDY5CW84vMw==;7:dNApTnUQnGRqEP2gMz5E9RXAXfRWLXwHu+4K22CpRcdrytcmqPAuASUXgbpvFIj+uJlvXGKAGqU9VEj35f6aQfFjO9YxeklOFrMLGeuw3zhP1YDocGCHp7bNYl8zwhilXD2qhkZIsDr11uHR1LNc/Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 13:02:44.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12d0dcf-3f71-49a1-15fd-08d6902136a6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 11:44:46 AM CET Peter Rosin wrote:
> On 2019-02-11 09:31, Federico Vaga wrote:
> 
> > Detecting a timeout is ok, but we also need to assert a STOP command on
> > the bus in order to prevent it from generating interrupts when there are
> > no on going transfers.
> > 
> > Example: very long transmission.
> > 
> > 1. ocores_xfer: START a transfer
> > 2. ocores_isr : handle byte by byte the transfer
> > 3. ocores_xfer: goes in timeout [[bugfix here]]
> > 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> > 5. I2C driver : it may clean up the i2c_msg memory
> > 6. ocores_isr : receives another interrupt (pending bytes to be
> > 
> >                 transferred) but the i2c_msg memory is invalid now
> > 
> > 
> > So, since the transfer was too long, we have to detect the timeout and
> > STOP the transfer.
> > 
> > Another point is that we have a critical region here. When handling the
> > timeout condition we may have a running IRQ handler. For this reason I
> > introduce a spinlock.
> > 
> > In order to make easier to understan locking I have:
> > - added a new function to handle timeout
> > - modified the current ocores_process() function in order to be protected
> > 
> >   by the new spinlock
> > 
> > Like this it is obvious at first sight that this locking serializes
> > the execution of ocores_process() and ocores_process_timeout()
> > 
> 
> 
> *snip*
> 
> 
> > @@ -184,14 +197,14 @@ static void ocores_process(struct ocores_i2c *i2c)
> > 
> >  
> >  
> >  				oc_setreg(i2c, OCI2C_DATA, addr);
> >  				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
> 
> 
> Didn't checkpatch complain about the double space? Fixing it fits in
> patch 5...

Apparently not, I will add the fix the checkpatch PATCH

> Cheers,
> Peter




