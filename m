Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ABC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E89C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="BMyDpRqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAVAlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:41:24 -0500
Received: from mail-eopbgr760119.outbound.protection.outlook.com ([40.107.76.119]:48498
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfAVAlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x1Ul0XPXdaNl+LgnAo5XLRrH80MUux5XIW9GbunHfk=;
 b=BMyDpRqOryxZ6kvcPoAVD+bauWOV8UPkurcWgOqxx2HrKZ1WjX5vmTnUBmyPQYl+b0CfU0Dltw8no8B4ERmCx2nYgu6YhRMJIf/je7aOhKiilniPwbUsoj8d+Oyi3mMeuNyyWBV81PfA6QUqaUJjLFP/5fzykChNrgI6aRuwBc4=
Received: from BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36) by
 MWHPR01MB3214.prod.exchangelabs.com (2603:10b6:300:fa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 00:38:27 +0000
Received: from BY2NAM03FT007.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::200) by BYAPR01CA0023.outlook.office365.com
 (2603:10b6:a02:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25 via Frontend
 Transport; Tue, 22 Jan 2019 00:38:27 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT007.mail.protection.outlook.com (10.152.84.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.11 via Frontend Transport; Tue, 22 Jan 2019 00:38:26 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x0M0cNeq024961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jan 2019 19:38:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B225D7A4C07; Mon, 21 Jan 2019 19:38:23 -0500 (EST)
Date:   Mon, 21 Jan 2019 19:38:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190122003823.GC19379@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
References: <20190118161440.220134-1-jannh@google.com>
 <20190121215454.GA12996@mit.edu>
 <20190121235158.GA4363@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190121235158.GA4363@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(75432002)(476003)(11346002)(186003)(26826003)(36906005)(486006)(786003)(90966002)(26005)(76176011)(446003)(33656002)(316002)(88552002)(6266002)(16586007)(4326008)(336012)(478600001)(126002)(2616005)(6246003)(47776003)(54906003)(23726003)(39060400002)(46406003)(2906002)(42186006)(7416002)(246002)(229853002)(8936002)(1076003)(8676002)(6916009)(58126008)(106466001)(86362001)(305945005)(106002)(52956003)(103686004)(356004)(50466002)(97756001)(36756003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB3214;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT007;1:dCaniQRNfvGCB+V2I5gOLSfTBSabEUDZaAPmUMw8OAs9Tuiscaj8mGsG5FN0jFpt5bb9+qmDe6uAGNfes1zXfDWivKWdy8ttWXZNruzORcyz39Z5SycsEWaJ9UN9REoTbREzscOTlg9QJTsSBux9dlj4mYoJjJamWwNzzthzfzU=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126091c4-2bb6-4f5f-38f2-08d68001ec87
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR01MB3214;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3214;3:PwnhSIgo0dHZFsAlQUmbokH1xnjeJl+KLBTqJAm4UKGKSX2qY1U9efpcxowqTM1hqsEZyMLya8+UXtlbHWFzIrGpH2VFSj8n9CN7K6gVDfFsdmgiiH5Z6I8Z6vKbguwM25cWE3UTPoaz+6b7YYzerl3Nu4kLtMjd8WDCAifJJ7JhAqOIvad0A5i3eltYGTOacyfz/l3FZwDK5QgjJzBtZdZMbX+b1xh9jMDSt10QvNzgBIjYLKSbTMxbTAT/LZPJL99fVlBjqoJP+u4lgsfA8zHsy5Kwb7O/ihRhmt90y4OivoKaSgerNEpEXlhmtlwjbNjIFXtmB405A5F6w5hTOo9OoNXPBJTU8NKTpdV3rjwx0M+eYgaT3UQ78nhdmyLL;25:C0lFfzO9ii5EuSQLImn5/UXM6Cgtk3lbhthlP3w1xHxyJen4nXdIXELyBWBvmOPYGcT0zMXvYHePyRstFhmERx+5oKwVurL6le8uJSRpE1rSJiVYDWn+JmJTsOw3XcQKoN/nMXhs5S9juPGdHWOKDG9YkNYNuvYJ3d4UA4proCrkei1SaAKhTUGZM/jEFiVrF2lUT45Z0mKPjjDYQV4Q7OA7us8T35xBfqRYUKDOY6bvPV/Ny0Gy56K4vt3CdSFbfUP8zFB2oUupDnJxd/06uYK1q7qZxVefzMCA/G6+5ciwpy2Hw+9ZxQb1ZVTZgSwxghogy2NI1eH2PtoY2eqEvg==
X-MS-TrafficTypeDiagnostic: MWHPR01MB3214:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3214;31:tjtKabkroZDzsvwUYebwY+ChKGxAN8U1RUGMvf72QIdLHSvvproUF/Kv18hi+1ADpbLtI0ujhWQVX3bX4BHuxo5kPOChNRMQ6/eZfVXnDn2xlOfAb2J2hOVo5OP0uRP43zrKpIpc16/hISDkN5+jcbnvqJDlpFs2Gbj5RhnKHh81MzlCFOxcAmHlvmNX3OsDdV4wkF6Oz5yQjyz2wiBIrjPRo6V8U7bw4qXB4CCufqY=;20:V2jUHhRxUQK9Shyh5xLoP7m8krkaUg09IADd25n8xo5DbwnY0QlPeZUAUgY5RYBuPuJoVbNFvdQZeaRCaxYJ93yA3iIbZ+SYzG4hgPtb+sjfVZAoe8szmkjP6I0QzJMqDeEk1++n+Rg8l2NRdRmIFD8TqcmVwagrcwiq6ma8VLMJZilaxvMg3RQPcrGvgCEZhck2nXdGrrs/iMOVwKYxerDE2deeS6+wS8BxCZenbU3UZ+dE7ypt3Tnt3Qp/I1ewVayYOGsKV0MGiGUmaol4NGLhQOsG+yWMhB9O+uDmgzHOQDNcFuEXA8wZz+74XVI2HMm+gtc8hye0UxsFbbCNJ2iNJOqWJxuLHrCnPflw88ZyPNgKlFF7JLVGiL2icn57S390Bij+mYZTzSN//xOMQub/qj9AEaaIVFLSMSrhZRX+NpTVKRb4sxeDDJHs/gotVoHE2vY985KxAiMAGmHH1Jbaq+sh2g01YgbZx+Z3pXX71noiiK+uTtRv3id/AQUB7BWhxJgWIpB7E7oxZ1HwQpJm5pLzd82YjgHFyz8Kmrxxw4D+/vEZrXp+iDIv8Q2TeqrTPxnwdKa2EtEfMh//lHqaA5KnmoRM6K4uowaBSwQ=
X-Microsoft-Antispam-PRVS: <MWHPR01MB32145B5C43212C68C8DFA0B1B5980@MWHPR01MB3214.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3214;4:n/bWNDZEeuHHxL7lxGnqKDcjgllQPbacLGdNwbcnjABzF/XqC5VI4fk8YnQed6Zdr4PDMX8zO7nRA5miTUVhzZsJJ9hBLviFIL5Lf8PtVY+Cim39E/o+GUwexVe9bCxPg0oVkN7l5Db5aWSyo8R0TSN1u7xp6p14RrzutQTIybefhXtgrcqKr3e6d9Fio7OTvrYiFt11dM2qERZSVRlmOY/RVZV63h6VCvMxHEXIFGbWiqRX2fNy8q609o2PvlIKeCEPJDwVOPe4i6Y3wERVO7InAVLxvVmWYek8kZqd3ywBBDW5tWzL5aWJLhP1XmdD
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR01MB3214;23:rXM68masvR3/qSLX3gefLdI8AjNBvulpV+DzY5/yS?=
 =?us-ascii?Q?P4faq35TSSCHpk7Fz2Hdfvq8FCUa0w7x4nwKfYql0kRNTOPnqiUwXbCDGZLp?=
 =?us-ascii?Q?HMYziAnIkfxlnrqk44atfRzyDKXvj+ToqXQ/D7nl4tIx74tvkt601WLqbRvY?=
 =?us-ascii?Q?fY7+l5BQskvgRQpskQEM0/3Q54qxsf+LlFAuAcR3k0KKOLJK0M4tDluYIm2Z?=
 =?us-ascii?Q?jENHMydoWa89iw00RZaATgQQbpQeuXpSPsQXWeQov8LmmDQzAjOrV7dMQ1cO?=
 =?us-ascii?Q?ehiz6VWtf33fXzdTrvK5J1ZWqCjj2JjSsGfXjq4HAMj2LXdAsLvwmBqkdYaM?=
 =?us-ascii?Q?OLDich1KDiCmdpIG10RgXcCAKQZ5F+cClH+DhTQkqkutyZqDq2h1vx9Rp3Vw?=
 =?us-ascii?Q?P5HPkZXk4FnfQoUIv80MCzPJJ4qCSUNARpLgIJ3uW70ccEujmX71bS0HBWqT?=
 =?us-ascii?Q?kd9SuonYAZDsxWvy85XihxCCezyEm9d/DyZUWKGX0bekogX40RhfGasHKwni?=
 =?us-ascii?Q?jtTxEWxzllgY5v9kscpJMSfbmav86MfkduU+Sft0/XJeNjrrX4+uYxHCo+O1?=
 =?us-ascii?Q?wdsxMh1G2jWyoHMiyBSNLmyX92iWKZAe5cd5aZKP0WP9SE4zrhk0zIOYycXw?=
 =?us-ascii?Q?H4p2gXjt/NU55FnjSYb4e+cXuGROW1dh4x0fbg3WdY+pdE+vgZFbpp7gTUr0?=
 =?us-ascii?Q?4NKwkx3ysMCaonrWyZ/ESqVv2gpY4udhe4+hiOmR6FKJpMJFqqxYhn4+W8/b?=
 =?us-ascii?Q?XTOFhr9C2WaC7hmmxFKQ4h1b+TbtKr3KadcATL8QfEE+/GPyKt4CkirSSbg5?=
 =?us-ascii?Q?ph6bDpBzHOhF6bswKGyhQtfqmhbICNtEwu29DtzFzAl3Hl8gztAyh01V9cKo?=
 =?us-ascii?Q?n9BEQDmfemqVJtt+ttt7IRfTrxsMnO3ucwqBuSzwmZA/CWBZClNsypW+5GaA?=
 =?us-ascii?Q?yj8eb4rO1UeNoLSs7n21PkgD76qRoEK9KixwHAtKWFH2g6H56edVRbLv7r7v?=
 =?us-ascii?Q?dOhs3QabaAzv/HqS9R6DfF/wZJCQV0omX6a35bKU44dHyrwv4FrTpdegoxBD?=
 =?us-ascii?Q?3aytNKtuIvn8lWJjAGGAUZCafUA69d1CUemtb6UZMgjJCQl7RWosR7JTdKRc?=
 =?us-ascii?Q?nTJBSK2U1ag1viXoPdPyHlzHrcHN4u9DzAf3FlyZKYdLis5TYilVe4IORIVQ?=
 =?us-ascii?Q?mGst1I6OT817l8czYzl/o3V9mOJkCgpv/WJT5etB2VzRwjJH9bvCg6WqEHY8?=
 =?us-ascii?Q?tp1aIcMWuysJYGojbJ3CSGu9R0GOgbuJ9c8P/2i?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m5Og7VHPz7xvmBI7EzKi0ukS6HeR+VG8TsRmu/x67wtoCj4UFXR+Hg3uuf2Y8crFWdfkWMjWqZQDRhoTMQQsU7JAD1/qfNmMqI+R4fi0VWmBziI3alzjGswRP5A/2divwIuCbBH5Iz5Khr0lF2C5n8jUiA40h+sAMIudv2QSisAZaG6HvIeSzaVWLISEA5vllwr2k01Qgt8+qa6jS6lkL10Y7/0Hhh9af+5B815aBgrliDJCe+Oo4rizmkwPlBX/QenUQ+zAltgohYaICgA5sju8xfFSeFLHX7Py1cuUs45dxIp+hO3sLW2vaqZleSJh8gpXBhTvQ6Kt5dPY4FD8XVxI1lBNvL0AbkKlhJrpuDgaC1K0u4QGjs9lcvz84TZD84HlHlMy+W8fMi0xDp/Hl9OH8frQ2xoHLQ+YptuyAug=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3214;6:mj/28cGiI5Fh32IWj59q1Jj5KxSgcRs5A6mOxil2jrwjMqmaN5xo+cEDSmDSAy2ZE3jx9CfHApDTI31IwrXYkyGWX95Onq2e84VDgck7xTTEurRiFxINrwA+8sGWrxe6XZLZhPY/zgYX1D+dpqhbZ4isN0aa9hBkwmwD8O41D2DRg/E+eTjdlI9/cvPDi8+ZdjapDduiIgBfA1AUNSBNALMYgbAeIwzconZ4bLxWHBGSH7RF28sqSOMWuudpnNM0KeEQ0+Nr+/Z2BkJYYg8t5LmAufMbJPtsP/8xqjWrBWVIHdUX+6TNa262SwxfWnZ/Sl0xrKB+llzCXe/6iey9RkIHKCziwM4wXcQL2elf3xkDvTMe5KhPHzPQucstdgtMSEHnfehQPAprG5d56GPJeeP8IQ2vPr1XHykczsc6xHlQ/bZcEkZfAyK/Aip1MtMcsTE2tqeeO+gOUD/LsF5j6Q==;5:obU9rR52lg4Zxg5RoeDU5ovkf3BGZIGJOL68Xd9p4uHAibfbkOfBO82RE44zWRTyPViM5ZjWF+xk78a6MR6lIdVXkpUs4IEF/ElH4YjpZ0I0uWowOddta7UUe25T0UFRxoXl0ry+Br2gbxgy74GD1axzdpaM4LRKwEHh9nlgySVFJbxrkhYQf0wBc/c/Y0tLszyEv09NDPfqFFQjUBh41Q==;7:Yd67dDxxrDU4MzNCHbWInTtywLe6YmKo7ae4l4YmUGq7BFe3UQIe4Ubh2Ni9ebmNutJqDhxEE5h9QX15iddUuMLknPRNWdiVC6IdmrTlgKt76ZBmrsOSAWkaIYw1Zn2or8EjHHTbWWalvqRIQhg5HA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 00:38:26.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126091c4-2bb6-4f5f-38f2-08d68001ec87
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:51:58PM -0800, Darrick J. Wong wrote:
> 
> I disagree with upending 13 years of established precedent for user
> visible behavior.  We possibly could've pulled this off ten years ago,
> but it's waaaay too late now.  Too much work, too little gain.

I remember the discussion; but now that we're adding it to uapi header
files, it's really going to be impossible.  And I have had some
regrets about that decision ten years ago.  I agree it would cause
confusion if we do it now, but it's basically the our last
opportunity.
 
How about this then?  We could ask glibc to change the string returned
by strerror for EUCLEAN/EFSCORRUPTED to be something like "File system
or block device corrupted".  This is how the errno is used in the
kernel; and if we don't want to change the error code, changing the
string returned by glibc should be less problematic.

					- Ted
