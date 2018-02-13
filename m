Return-Path: <prvs=5756e5741=paf@cray.com>
X-Google-Smtp-Source: AH8x227Ap4ytR/xmFZ+ELAlVKan0NafIuj9CAnTGQEbPCreKpw/XjKhjeSJqJcN6/ZB4LIlya+a/
ARC-Seal: i=1; a=rsa-sha256; t=1518482815; cv=none;
        d=google.com; s=arc-20160816;
        b=HYZXNXYEvY1AAV7gvnk6K+4xP/gtnNEy+lGdzz5F6PcWhtPP+fA9aCIjyVoXbYyudX
         3GgILIWrrVpbz0pa6e//AUyCx5QIo2Zrt4UuXgR21nAIjrK/VT2PG7RTQ7gxfEeTNp/+
         MEbXd5PeS+C2h08PJos0noIZjank/suZsjsVidJjbiwoa/fOmNDtDT8cw+YSTa5ApvH9
         Kof/+N+M3htK1354rROeBQ4y/9BGl4yK4XI3bA6sAKJ9sw/uMfZL5LT55b/c1U9FKxD4
         9cF66pUG10mbX2saXpnPV4jifKhFjAVMlBclQZ4NoFRxGPehdbj3YCCDs+mXozt7auFO
         Raow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=kdfpInedjw9gIIcZ7v0/XwLeZlA+FIgtQ+/FKCe8KJg=;
        b=F7Ek4OTnRn8i3uDpRwpTbSV88JBLLs6r0ShIEN0KeHogBmDmqKhEHAUoybV4XSrM7r
         zx/kwcOwzWxAaZfxQy0iSQ69KHBw4Tqq8LdEEFdsGJd8TuVsP4xsHdzPcVIdYnj844v3
         tbut5ABcYN8WB9qH9wY2EcuAXPNlg11kd63HpGN4tfz9bv5BlnISLAkzqLuQT+angpzW
         Onzb6N5oOQ+Wn+tXd8jXWsaH8ZpUToBekRdRaUyxapyJVKYwl6iMV3hp2GKQIjasTZ8v
         44MhUfJIGwi0sj57RqAtSbXbz3oNOmyu1vTBPAt0ZK4tud0Yh0NTS47tRz4SHjhpyhb1
         SpSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=zxbmQ/kj;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=hcpYu6hU;
       spf=pass (google.com: domain of prvs=5756e5741=paf@cray.com designates 68.232.143.164 as permitted sender) smtp.mailfrom=prvs=5756e5741=paf@cray.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=zxbmQ/kj;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=hcpYu6hU;
       spf=pass (google.com: domain of prvs=5756e5741=paf@cray.com designates 68.232.143.164 as permitted sender) smtp.mailfrom=prvs=5756e5741=paf@cray.com
X-IronPort-AV: E=Sophos;i="5.46,504,1511827200";
   d="scan'208,217";a="17955453"
X-Cray-OBMMKR: 1433258124 17955453
From: Patrick Farrell <paf@cray.com>
To: NeilBrown <neilb@suse.com>, Oleg Drokin <oleg.drokin@intel.com>, "Andreas
 Dilger" <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: lkml <linux-kernel@vger.kernel.org>, lustre
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 08/19] staging: lustre: simplify waiting in
 ldlm_completion_ast()
Thread-Topic: [lustre-devel] [PATCH 08/19] staging: lustre: simplify waiting
 in ldlm_completion_ast()
Thread-Index: AQHTpEfozrbM95cnIUGwArRq++a4gKOg7wCAgACIeACAAAbSwA==
Date: Tue, 13 Feb 2018 00:46:51 +0000
Message-ID: <BN6PR1101MB2132A4E444F38C9BAF7FDC52CBF60@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <151847037709.22826.16175867257667686132.stgit@noble>
 <151847055674.22826.12912356108048917428.stgit@noble>
 <4AC4BB93-85C5-4CA1-B062-1274833C51C6@cray.com>,<87o9ktrbe5.fsf@notabene.neil.brown.name>
In-Reply-To: <87o9ktrbe5.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=paf@cray.com; 
x-originating-ip: [2601:443:480:1e55:1836:53cf:f8a2:7bb7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2162;7:ggzErr+LNiY7HvIgNpxFaMEsgboIUYEnKd6VQzAHgIxUKtCLi+PwqmysGKhnidIzWMP5RlnQWsulEpJ5I7kGCCt69vZ/s5gh0PqetpLTMXdM4YZ/NyGM20A7YGAzqi3UhxvG4Hx7XGya/J5Kjk+24+tumHjKMdjM5FYzP18DjpqJXotOZAHWK5A80Q2dNMm7gcMy0XBN7kcgtmPQzw/6v9vS9i0iTFeVWShGyX037+jHAqhzv3oT1G6r8Lqy95aF
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0efc5d28-0dcd-453b-7508-08d5727b4587
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6PR1101MB2162;
x-ms-traffictypediagnostic: BN6PR1101MB2162:
x-microsoft-antispam-prvs: <BN6PR1101MB2162F6F019E766C28C1D29ECCBF60@BN6PR1101MB2162.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR1101MB2162;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2162;
x-forefront-prvs: 0582641F53
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(376002)(39830400003)(366004)(199004)(189003)(51444003)(93886005)(2950100002)(55016002)(229853002)(81166006)(8676002)(6436002)(5660300001)(53936002)(9686003)(7736002)(54896002)(81156014)(8936002)(86362001)(6246003)(74316002)(2900100001)(6116002)(33656002)(4326008)(106356001)(25786009)(316002)(102836004)(105586002)(2906002)(68736007)(54906003)(110136005)(14454004)(77096007)(186003)(7696005)(99286004)(478600001)(6506007)(53546011)(3660700001)(59450400001)(76176011)(97736004)(3280700002)(13693001)(21314002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1101MB2162;H:BN6PR1101MB2132.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DMAYYzFRd2fg6VxT32mn7CZn1HvqegkR5g8j9dyvBG10dXwsdGEKjl8LHDLLQhJDe1xfdOC4LO9F7HTnyAVBBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1101MB2132A4E444F38C9BAF7FDC52CBF60BN6PR1101MB2132_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efc5d28-0dcd-453b-7508-08d5727b4587
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 00:46:51.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2162
X-OriginatorOrg: cray.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231861062476291?=
X-GMAIL-MSGID: =?utf-8?q?1592244637214684100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--_000_BN6PR1101MB2132A4E444F38C9BAF7FDC52CBF60BN6PR1101MB2132_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Yes, I assume it=92s a comment about stack usage (or even more out of date =
and unrelated to the current code entirely. :p)  Like you, I can=92t imagin=
e what else it would be...

You=92re probably right about the locking issue, I=92m happy to defer.  (In=
 any case, this timed out path should be very far from hot...)

Otherwise that fix looks good.  I=92ll review the rest of these tomorrow.

________________________________
From: NeilBrown <neilb@suse.com>
Sent: Monday, February 12, 2018 6:17:22 PM
To: Patrick Farrell; Oleg Drokin; Andreas Dilger; James Simmons; Greg Kroah=
-Hartman
Cc: lkml; lustre
Subject: Re: [lustre-devel] [PATCH 08/19] staging: lustre: simplify waiting=
 in ldlm_completion_ast()

On Mon, Feb 12 2018, Patrick Farrell wrote:

> Neil,
>
> I didn't get anything after 8/19 in this series.  Is this just me?  (I'd =
keep waiting, except I also found a few things in this patch.)

Not just you.  My fault.  They are appearing now.

>
> Minor:
> The line XXX ALLOCATE is out of date and could go.  (It refers to a
> mix of things you eliminated and things that were already gone.)

What does the line even mean?  Some comment about stack usage?
I think we have a look that looks for large stack frames.  I wonder how
to run it...

>
> Less minor:
> You remove use of the imp_lock when reading the connection count.  While =
that'll work on x86, it's probably wrong on some architecture to read that =
without taking the lock...?

It was my understanding that on all architectures which Linux support, a
32bit aligned read is atomic wrt any 32bit write.  I have trouble imagining=
 how
it could be otherwise.

I probably should have highlighted the removal of the spinlock in the
patch description though - it was intentional.

>
> Bug:
> The existing code uses the imp_conn_cnt from *before* the wait, rather
> than after.  I think that's quite important.  So you'll want to read
> it out before the wait.  I think the main reason we'd hit the timeout
> is a disconnect, which should cause a reconnect, so it's very
> important to use the value from *before* the wait.  (See comment on
> ptlrpc_set_import_discon for more of an explanation.  Basically it's
> tracking a connection 'epoch', if it's changed, someone else already
> went through the reconnect code for this 'connection epoch' and we
> shouldn't start that process.)
>

That wasn't intentional though - thanks for catching!
Looking at  ptlrpc_set_import_discon(), which is where the number
eventually gets used, it is only used to compare with the new value of
imp->imp_conn_cnt.

This would fix both (assuming the locking issue needs fixing).

Thanks,
NeilBrown

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/st=
aging/lustre/lustre/ldlm/ldlm_request.c
index f1233d844bbd..c3c9186b74ce 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -103,7 +103,7 @@ static int ldlm_request_bufsize(int count, int type)
         return sizeof(struct ldlm_request) + avail;
 }

-static void ldlm_expired_completion_wait(struct ldlm_lock *lock, struct ob=
d_import *imp2)
+static void ldlm_expired_completion_wait(struct ldlm_lock *lock, __u32 con=
n_cnt)
 {
         struct obd_import *imp;
         struct obd_device *obd;
@@ -129,7 +129,7 @@ static void ldlm_expired_completion_wait(struct ldlm_lo=
ck *lock, struct obd_impo

         obd =3D lock->l_conn_export->exp_obd;
         imp =3D obd->u.cli.cl_import;
-       ptlrpc_fail_import(imp, imp2 ? imp2->imp_conn_cnt : 0);
+       ptlrpc_fail_import(imp, conn_cnt);
         LDLM_ERROR(lock,
                    "lock timed out (enqueued at %lld, %llds ago), entering=
 recovery for %s@%s",
                    (s64)lock->l_last_activity,
@@ -241,6 +241,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 f=
lags, void *data)
         struct obd_device *obd;
         struct obd_import *imp =3D NULL;
         __u32 timeout;
+       __u32 conn_cnt =3D 0;
         int rc =3D 0;

         if (flags =3D=3D LDLM_FL_WAIT_NOREPROC) {
@@ -268,6 +269,11 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 =
flags, void *data)

         lock->l_last_activity =3D ktime_get_real_seconds();

+       if (imp) {
+               spin_lock(&imp->imp_lock);
+               conn_cnt =3D imp->imp_conn_cnt;
+               spin_unlock(&imp->imp_lock);
+       }
         if (OBD_FAIL_CHECK_RESET(OBD_FAIL_LDLM_INTR_CP_AST,
                                  OBD_FAIL_LDLM_CP_BL_RACE | OBD_FAIL_ONCE)=
) {
                 ldlm_set_fail_loc(lock);
@@ -280,7 +286,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 f=
lags, void *data)
                                                      is_granted_or_cancell=
ed(lock),
                                                      timeout * HZ);
                         if (rc =3D=3D 0)
-                               ldlm_expired_completion_wait(lock, imp);
+                               ldlm_expired_completion_wait(lock, conn_cnt=
);
                 }
                 /* Now wait abortable */
                 if (rc =3D=3D 0)

--_000_BN6PR1101MB2132A4E444F38C9BAF7FDC52CBF60BN6PR1101MB2132_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
Yes, I assume it=92s a comment about stack usage (or even more out of date =
and unrelated to the current code entirely. :p)&nbsp; Like you, I can=92t i=
magine what else it would be...<br>
<br>
You=92re probably right about the locking issue, I=92m happy to defer.&nbsp=
; (In any case, this timed out path should be very far from hot...)<br>
<br>
Otherwise that fix looks good.&nbsp; I=92ll review the rest of these tomorr=
ow.<br>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> NeilBrown &lt;neilb@s=
use.com&gt;<br>
<b>Sent:</b> Monday, February 12, 2018 6:17:22 PM<br>
<b>To:</b> Patrick Farrell; Oleg Drokin; Andreas Dilger; James Simmons; Gre=
g Kroah-Hartman<br>
<b>Cc:</b> lkml; lustre<br>
<b>Subject:</b> Re: [lustre-devel] [PATCH 08/19] staging: lustre: simplify =
waiting in ldlm_completion_ast()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Feb 12 2018, Patrick Farrell wrote:<br>
<br>
&gt; Neil,<br>
&gt;<br>
&gt; I didn't get anything after 8/19 in this series.&nbsp; Is this just me=
?&nbsp; (I'd keep waiting, except I also found a few things in this patch.)=
<br>
<br>
Not just you.&nbsp; My fault.&nbsp; They are appearing now.<br>
<br>
&gt;<br>
&gt; Minor:<br>
&gt; The line XXX ALLOCATE is out of date and could go.&nbsp; (It refers to=
 a<br>
&gt; mix of things you eliminated and things that were already gone.)<br>
<br>
What does the line even mean?&nbsp; Some comment about stack usage?<br>
I think we have a look that looks for large stack frames.&nbsp; I wonder ho=
w<br>
to run it...<br>
<br>
&gt;<br>
&gt; Less minor:<br>
&gt; You remove use of the imp_lock when reading the connection count.&nbsp=
; While that'll work on x86, it's probably wrong on some architecture to re=
ad that without taking the lock...?<br>
<br>
It was my understanding that on all architectures which Linux support, a<br=
>
32bit aligned read is atomic wrt any 32bit write.&nbsp; I have trouble imag=
ining how<br>
it could be otherwise.<br>
<br>
I probably should have highlighted the removal of the spinlock in the<br>
patch description though - it was intentional.<br>
<br>
&gt;<br>
&gt; Bug:<br>
&gt; The existing code uses the imp_conn_cnt from *before* the wait, rather=
<br>
&gt; than after.&nbsp; I think that's quite important.&nbsp; So you'll want=
 to read<br>
&gt; it out before the wait.&nbsp; I think the main reason we'd hit the tim=
eout<br>
&gt; is a disconnect, which should cause a reconnect, so it's very<br>
&gt; important to use the value from *before* the wait.&nbsp; (See comment =
on<br>
&gt; ptlrpc_set_import_discon for more of an explanation.&nbsp; Basically i=
t's<br>
&gt; tracking a connection 'epoch', if it's changed, someone else already<b=
r>
&gt; went through the reconnect code for this 'connection epoch' and we<br>
&gt; shouldn't start that process.) <br>
&gt;<br>
<br>
That wasn't intentional though - thanks for catching!<br>
Looking at&nbsp; ptlrpc_set_import_discon(), which is where the number<br>
eventually gets used, it is only used to compare with the new value of<br>
imp-&gt;imp_conn_cnt. <br>
<br>
This would fix both (assuming the locking issue needs fixing).<br>
<br>
Thanks,<br>
NeilBrown<br>
<br>
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/st=
aging/lustre/lustre/ldlm/ldlm_request.c<br>
index f1233d844bbd..c3c9186b74ce 100644<br>
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c<br>
&#43;&#43;&#43; b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c<br>
@@ -103,7 &#43;103,7 @@ static int ldlm_request_bufsize(int count, int type=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct ldlm_=
request) &#43; avail;<br>
&nbsp;}<br>
&nbsp;<br>
-static void ldlm_expired_completion_wait(struct ldlm_lock *lock, struct ob=
d_import *imp2)<br>
&#43;static void ldlm_expired_completion_wait(struct ldlm_lock *lock, __u32=
 conn_cnt)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct obd_import *imp;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct obd_device *obd;<br=
>
@@ -129,7 &#43;129,7 @@ static void ldlm_expired_completion_wait(struct ldl=
m_lock *lock, struct obd_impo<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obd =3D lock-&gt;l_conn_ex=
port-&gt;exp_obd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; imp =3D obd-&gt;u.cli.cl_i=
mport;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptlrpc_fail_import(imp, imp2 ? imp2-&=
gt;imp_conn_cnt : 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptlrpc_fail_import(imp, conn_cnt)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LDLM_ERROR(lock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lock timed out (enqueued at %=
lld, %llds ago), entering recovery for %s@%s&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s64)lock-&gt;l_last_activity,<br>
@@ -241,6 &#43;241,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u=
64 flags, void *data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct obd_device *obd;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct obd_import *imp =3D=
 NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 timeout;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 conn_cnt =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags =3D=3D LDLM_FL_W=
AIT_NOREPROC) {<br>
@@ -268,6 &#43;269,11 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __=
u64 flags, void *data)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock-&gt;l_last_activity =
=3D ktime_get_real_seconds();<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (imp) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spin_lock(&amp;imp-&gt;imp_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; conn_cnt =3D imp-&gt;imp_conn_cnt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spin_unlock(&amp;imp-&gt;imp_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (OBD_FAIL_CHECK_RESET(O=
BD_FAIL_LDLM_INTR_CP_AST,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBD_FAIL_LDLM_CP_BL_RACE |=
 OBD_FAIL_ONCE)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ldlm_set_fail_loc(lock);<br>
@@ -280,7 &#43;286,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u=
64 flags, void *data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; is_granted_or_cancelled(lock),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; timeout * HZ);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
c =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ldlm_expired_completion_wait(lock, imp);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ldlm_expired_completion_wait(lock, conn=
_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Now wait abortable */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rc =3D=3D 0)<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR1101MB2132A4E444F38C9BAF7FDC52CBF60BN6PR1101MB2132_--
