Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeDRQJV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:09:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751431AbeDRQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:09:19 -0400
From: Song Liu <songliubraving@fb.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Topic: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Index: AQHT1t6qY2w++l1Em02GF9oER/KoaKQGjmAAgAAi9YA=
Date: Wed, 18 Apr 2018 16:08:50 +0000
Message-ID: <6E88C284-7EEB-43EF-8C54-3DCB5F13124B@fb.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
In-Reply-To: <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:180::1:db29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1689;7:8TelGywGWPt5EHFk/oIhRnSeRB/MfjU10HdarJziAJv18RC06NSLOZKjhkBTXiKq4gs1eq0pn4XXECmWWyRmyRXeELOHTgMbmmc/kS+b2VNXfsTJzPMFdmB8MlMQrIPkIb/yHLLL/9Sh3l8FYsaAhd5xlFC1gA3xF96VevAgPK7GXpETqMVjOV7lCTRsrJoAdG162zwrIPV/crYIO6ESnssAM426zLjQCGFWCf0VagFdcqCVPK8jQYXZ61IngP2c;20:87Pm9dTVfloOKkI/nhELGfm/iJ5cEq7/xAxKEmwQhr5eyoNvcqY176GraT3onOhga88RoSFWW22+UN6dBQ8tYOl7EjJQRLVO7eoku9ZtX07lKz55upeVBhppTRxwYofp4MMAyr/R7D3vulVq8YVb5SsSfXuUdD4xY4uMd4g74Tw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1689;
x-ms-traffictypediagnostic: DM5PR15MB1689:
x-microsoft-antispam-prvs: <DM5PR15MB16896379678732FEC2D18747B3B60@DM5PR15MB1689.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(11241501184)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1689;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1689;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(39860400002)(376002)(53546011)(11346002)(86362001)(305945005)(6486002)(7736002)(81166006)(8676002)(76176011)(5660300001)(6916009)(25786009)(82746002)(6506007)(102836004)(59450400001)(4326008)(2616005)(33656002)(14454004)(476003)(36756003)(478600001)(6246003)(186003)(54906003)(50226002)(53936002)(6512007)(6116002)(6436002)(2906002)(446003)(5250100002)(83716003)(99286004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1689;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: lUwwihtJ04JGy7TQ+F58iZ6sIQ1H5d6qsQB+2ZGxfJkGXGK/voZdCdEgHBtVYoTjkGnuR9HOeWv2DcVeLFxkJF7jLEFUyaVHYUvoKPEfgi4635Ng6Wwq8AdJ3XdcyLdiHj70i3jgJh68hISBT+JlZHpopu6RLocTfO9oqYr1wKfNtUo7ksn1VeWOQshGLXyC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F718891AC9BFB142954E208113973109@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4d699cc3-8f22-44c5-11ba-08d5a546ac8d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d699cc3-8f22-44c5-11ba-08d5a546ac8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 16:08:50.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1689
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3IG9R6A012180


> On Apr 18, 2018, at 7:03 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> On Wed, Apr 18, 2018 at 8:29 AM, Song Liu <songliubraving@fb.com> wrote:
>> As Miklos reported and suggested:
>> 
>>  This pattern repeats two times in trace_uprobe.c and in
>>  kernel/events/core.c as well:
>> 
>>      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>>      if (ret)
>>          goto fail_address_parse;
>> 
>>      inode = igrab(d_inode(path.dentry));
>>      path_put(&path);
>> 
>>  And it's wrong.  You can only hold a reference to the inode if you
>>  have an active ref to the superblock as well (which is normally
>>  through path.mnt) or holding s_umount.
>> 
>>  This way unmounting the containing filesystem while the tracepoint is
>>  active will give you the "VFS: Busy inodes after unmount..." message
>>  and a crash when the inode is finally put.
>> 
>>  Solution: store path instead of inode.
>> 
>> This patch fixes two instances in trace_uprobe.c.
>> 
>> Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
>> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Howard McLauchlan <hmclauchlan@fb.com>
>> Cc: Josef Bacik <jbacik@fb.com>
>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> kernel/trace/trace_uprobe.c | 42 ++++++++++++++----------------------------
>> 1 file changed, 14 insertions(+), 28 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index 0d450b4..80dfcdf 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -55,7 +55,7 @@ struct trace_uprobe {
>>        struct list_head                list;
>>        struct trace_uprobe_filter      filter;
>>        struct uprobe_consumer          consumer;
>> -       struct inode                    *inode;
>> +       struct path                     path;
>>        char                            *filename;
>>        unsigned long                   offset;
>>        unsigned long                   nhit;
>> @@ -289,7 +289,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>>        for (i = 0; i < tu->tp.nr_args; i++)
>>                traceprobe_free_probe_arg(&tu->tp.args[i]);
>> 
>> -       iput(tu->inode);
>> +       path_put(&tu->path);
>>        kfree(tu->tp.call.class->system);
>>        kfree(tu->tp.call.name);
>>        kfree(tu->filename);
>> @@ -363,7 +363,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>> static int create_trace_uprobe(int argc, char **argv)
>> {
>>        struct trace_uprobe *tu;
>> -       struct inode *inode;
>>        char *arg, *event, *group, *filename;
>>        char buf[MAX_EVENT_NAME_LEN];
>>        struct path path;
>> @@ -371,7 +370,6 @@ static int create_trace_uprobe(int argc, char **argv)
>>        bool is_delete, is_return;
>>        int i, ret;
>> 
>> -       inode = NULL;
>>        ret = 0;
>>        is_delete = false;
>>        is_return = false;
>> @@ -448,14 +446,6 @@ static int create_trace_uprobe(int argc, char **argv)
>>        if (ret)
>>                goto fail_address_parse;
>> 
>> -       inode = igrab(d_inode(path.dentry));
> 
> This is not against -linus tree.

These patches are against tip/perf/core. I can also send version against 
-linus tree. 

> 
>> -       path_put(&path);
>> -
>> -       if (!inode || !S_ISREG(inode->i_mode)) {
>> -               ret = -EINVAL;
>> -               goto fail_address_parse;
>> -       }
>> -
>>        ret = kstrtoul(arg, 0, &offset);
>>        if (ret)
>>                goto fail_address_parse;
>> @@ -490,7 +480,8 @@ static int create_trace_uprobe(int argc, char **argv)
>>                goto fail_address_parse;
>>        }
>>        tu->offset = offset;
>> -       tu->inode = inode;
>> +       tu->path.mnt = path.mnt;
>> +       tu->path.dentry = path.dentry;
> 
> You can just assign the whole structure.  No need to mess with
> individual members.
> 
>        tu->path = path;
Will fix in v2. 
> 
>>        tu->filename = kstrdup(filename, GFP_KERNEL);
>> 
>>        if (!tu->filename) {
>> @@ -558,7 +549,7 @@ static int create_trace_uprobe(int argc, char **argv)
>>        return ret;
>> 
>> fail_address_parse:
>> -       iput(inode);
>> +       path_put(&path);
>> 
>>        pr_info("Failed to parse address or file.\n");
>> 
>> @@ -937,7 +928,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>>                goto err_flags;
>> 
>>        tu->consumer.filter = filter;
>> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>> +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
>> +                             &tu->consumer);
> 
> It is not entirely clear how the lifetime of uprobe relates to the
> lifetime of trace_uprobe.  Is the uprobe object never going to survive
> its creator trace_uprobe object?
> 
> If that's the case, it warrants a comment.  If that's not the case,
> then the path would need to be passed to uprobe_resister() which would
> need to obtain its own reference.

trace_uprobe will not be freed before the uprobe object. trace_uprobe 
holds reference to struct path (with path_get()). 

> 
>>        if (ret)
>>                goto err_buffer;
>> 
>> @@ -981,7 +973,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>> 
>>        WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>> 
>> -       uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>> +       uprobe_unregister(d_inode(tu->path.dentry), tu->offset, &tu->consumer);
>>        tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
>> 
>>        uprobe_buffer_disable();
>> @@ -1056,7 +1048,8 @@ static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
>>        write_unlock(&tu->filter.rwlock);
>> 
>>        if (!done)
>> -               return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
>> +               return uprobe_apply(d_inode(tu->path.dentry), tu->offset,
>> +                                   &tu->consumer, false);
>> 
>>        return 0;
>> }
>> @@ -1088,7 +1081,8 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>> 
>>        err = 0;
>>        if (!done) {
>> -               err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
>> +               err = uprobe_apply(d_inode(tu->path.dentry),
>> +                                  tu->offset, &tu->consumer, true);
>>                if (err)
>>                        uprobe_perf_close(tu, event);
>>        }
>> @@ -1352,7 +1346,6 @@ struct trace_event_call *
>> create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>> {
>>        struct trace_uprobe *tu;
>> -       struct inode *inode;
>>        struct path path;
>>        int ret;
>> 
>> @@ -1360,14 +1353,6 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>>        if (ret)
>>                return ERR_PTR(ret);
>> 
>> -       inode = igrab(d_inode(path.dentry));
>> -       path_put(&path);
>> -
>> -       if (!inode || !S_ISREG(inode->i_mode)) {
>> -               iput(inode);
>> -               return ERR_PTR(-EINVAL);
>> -       }
>> -
>>        /*
>>         * local trace_kprobes are not added to probe_list, so they are never
>>         * searched in find_trace_kprobe(). Therefore, there is no concern of
>> @@ -1383,7 +1368,8 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>>        }
>> 
>>        tu->offset = offs;
>> -       tu->inode = inode;
>> +       tu->path.mnt = path.mnt;
>> +       tu->path.dentry = path.dentry;
> 
> tu->path = path
> 
> 
>>        tu->filename = kstrdup(name, GFP_KERNEL);
>>        init_trace_event_call(tu, &tu->tp.call);
>> 
>> --
>> 2.9.5
>> 
