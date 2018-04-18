Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDRQQH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:16:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750872AbeDRQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:16:06 -0400
From: Song Liu <songliubraving@fb.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Miklos Szeredi <miklos@szeredi.hu>,
        LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Topic: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Index: AQHT1t6qY2w++l1Em02GF9oER/KoaKQGjmAAgAAF+ACAAB7zAA==
Date: Wed, 18 Apr 2018 16:15:50 +0000
Message-ID: <939B1EB1-07D3-473F-B7D1-21E7B0F6CF13@fb.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
 <20180418102504.7673a7f3@gandalf.local.home>
In-Reply-To: <20180418102504.7673a7f3@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:180::1:db29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1611;7:Tkt7oY7UR88NVU1M0ig/0tWLVImgXeS+qDqoqKwm1i8SquPRBxGu9VJK3QvRfmcrMsZ1WFjmnkQiJ9187rs94Bej3odqIWiexT+PRsL4axG1qIM5C7qCXR5NcKGbk2qq2JEmj9vL/b+DGepY4qk/2CJnc5AOeNpLlSL+44yNf5c4G5GBopt6cg62MULgbwUhMKvYvS0+SxiOQYGLO4ZG0bcjMgm3b+OaVS9xXYONbzWxse1o9NjltC9RpzQOx+tA;20:HsmaR0f9EVT8uQecr/ECaTLvGM7hSO/NiqN7ERCBRHiNryrb9ELRzyvmA5KOy76HzBR+PfCoz+b/RjACQc5tbTBUsczNfkDa09qwWOWW17a0i+qgUA3GMOoXGlzFMw9rOperzuuALDg+a95MN7xWRHJkJEI6NF+kpmkkcEwrO6g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1611;
x-ms-traffictypediagnostic: DM5PR15MB1611:
x-microsoft-antispam-prvs: <DM5PR15MB16114E8960A1F2DCBC682F7EB3B60@DM5PR15MB1611.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(11241501184)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1611;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1611;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(366004)(6506007)(2906002)(102836004)(6116002)(82746002)(305945005)(6436002)(6512007)(7736002)(478600001)(33656002)(6486002)(14454004)(53546011)(54906003)(53936002)(4326008)(5250100002)(81166006)(8676002)(99286004)(5660300001)(8936002)(83716003)(76176011)(186003)(25786009)(11346002)(446003)(2616005)(476003)(36756003)(86362001)(50226002)(6246003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1611;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: hobDkoVjqlocUA8YsZGy4wtlWDlvY9GHwsB1YMw7Ec/A36ruOC1hRloh+9G9nJhlSqaSHEsXcDvYQAH1v1KqbGIeHzcYZ1J8e0d0tTV5+JW+i+OUNapR/WFsTu8sHnojN3199tkaz0SChfeWDR5VvrfxISXSg8Cor8klsbXPbVIEyYmpKQqpRpVJQFQ11RQX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CB3466784AB09459DA4CC3625D04484@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f005e8bd-b8f0-4811-47ce-08d5a547a73c
X-MS-Exchange-CrossTenant-Network-Message-Id: f005e8bd-b8f0-4811-47ce-08d5a547a73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 16:15:50.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1611
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3IGGDDI012218



> On Apr 18, 2018, at 7:25 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Wed, 18 Apr 2018 16:03:42 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
>>> @@ -937,7 +928,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>>>                goto err_flags;
>>> 
>>>        tu->consumer.filter = filter;
>>> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>>> +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
>>> +                             &tu->consumer);  
>> 
>> It is not entirely clear how the lifetime of uprobe relates to the
>> lifetime of trace_uprobe.  Is the uprobe object never going to survive
>> its creator trace_uprobe object?
> 
> Not exactly sure what you mean here.
> 
> The trace_uprobe (the probe event) is created, it doesn't do anything
> until it is enabled. This function is called when it is enabled. The
> trace_uprobe (probe event) can not be deleted while it is enabled
> (EBUSY).
> 
> Are you asking what happens if the file is deleted while it has probe?
> That I don't know about (haven't tried it out). But I would hope that
> it keeps a reference to the inode, isn't that what the igrab is for?
> And is now being replaced by a reference on the path, or is that the
> problem?
> 
> -- Steve
> 

Just as Miklos pointed out, I run tests with the uprobe and confirmed 
that igrab() is not sufficient to prevent umount. When we change it to 
path_get()/path_put(), umount will abort because of the trace_uprobe. 

Song


>> 
>> If that's the case, it warrants a comment.  If that's not the case,
>> then the path would need to be passed to uprobe_resister() which would
>> need to obtain its own reference.
>> 
>>>        if (ret)
>>>                goto err_buffer;
>>> 
