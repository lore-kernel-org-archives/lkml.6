Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4/yhJngbwfZGqpcYjKsfrv8ACyQSwa/zhYEldwhpW4hVTFSTu36tNzyiXezx02lCMfoe1qL
ARC-Seal: i=1; a=rsa-sha256; t=1522891648; cv=none;
        d=google.com; s=arc-20160816;
        b=qRxJyarOY93E8Be3diRYTlgfZlW/BddNjm0xTKZrU4tfyBY2pHfa19ghVDYG7fVk4v
         vUnIQiMcmAfqj6K9dXG6NmIwqQdQX02bqbRaExGunbtVipbdB/G78xERaIVSt6zmEQqm
         TqdCqMIf/mII4u0zjTfoAMrGOJ1yIGz68bWiGU7E2lyWlH16mT/mjWtgxS9h60RAp1u4
         TumG3wonoqZPBJHM57fdLOK83rNjKk1t2kA0ZZ+GvQ6MFiLVY5n2PUmVrAvo5jjK8StU
         6OHeqS5BMY2HndQD/N3Ac1OYrgwQyPWISDDsm/NSBE1QLk7JM9HJN8nn+H2QnheUq7n8
         u8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:arc-authentication-results;
        bh=GGecD+nJdkIclxeAciECq1tgylGlucNCH/iem2Tfkwo=;
        b=Yi+DFisOPOkaz4D8apq250PnDj0RNuupt1NpDWdin3IKNF5uXwXeai9qQxSZxkvZUq
         yLq1EzoBG3tDb8XO3ClutPgwy4UHtmYOWTQIqKjEN9Smd5XMM32YgcSUD2hLZLehwf5Y
         QUbik5f5ofMWq0T6Wzf9Z5+ffbuRXAABdPFirRusglKff0VjuBvxDXEfkxFIPpnEVcgu
         fAZwpSYWEPa/Ce5K1Wqz8I2aewCNwTo344JnjyuYeYq6fwVejIUIfIOh3uwxbRpj5Hjy
         cLgN0kajhPRk7lskTjsB/KJLHzPVFf59POaaNrF5HDaIZHwGjybvy+LBHHmeOLRqXdsV
         U5oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
MIME-Version: 1.0
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
 <20180404203048.GA21118@gmail.com> <871sfuha2d.fsf@xmission.com>
In-Reply-To: <871sfuha2d.fsf@xmission.com>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 05 Apr 2018 01:27:16 +0000
Message-ID: <CAPP7u0VQc33MiYP8Ene6K1Bqkx4LtBtQ0ugFYp_36UsxuusT1g@mail.gmail.com>
Subject: Re: [PATCH net] netns: filter uevents correctly
To: "Eric W. Biederman" <ebiederm@xmission.com>, David Miller <davem@davemloft.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrei Vagin <avagin@virtuozzo.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>, Serge Hallyn <serge@hallyn.com>
Content-Type: multipart/alternative; boundary="001a114780aca6155405690fd7aa"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596867633157756083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114780aca6155405690fd7aa
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 5, 2018, 00:39 Eric W. Biederman <ebiederm@xmission.com> wrote:

> Christian Brauner <christian.brauner@canonical.com> writes:
>
> > On Wed, Apr 04, 2018 at 09:48:57PM +0200, Christian Brauner wrote:
> >> commit 07e98962fa77 ("kobject: Send hotplug events in all network
> namespaces")
> >>
> >> enabled sending hotplug events into all network namespaces back in 2010.
> >> Over time the set of uevents that get sent into all network namespaces
> has
> >> shrunk. We have now reached the point where hotplug events for all
> devices
> >> that carry a namespace tag are filtered according to that namespace.
> >>
> >> Specifically, they are filtered whenever the namespace tag of the
> kobject
> >> does not match the namespace tag of the netlink socket. One example are
> >> network devices. Uevents for network devices only show up in the network
> >> namespaces these devices are moved to or created in.
> >>
> >> However, any uevent for a kobject that does not have a namespace tag
> >> associated with it will not be filtered and we will *try* to broadcast
> it
> >> into all network namespaces.
> >>
> >> The original patchset was written in 2010 before user namespaces were a
> >> thing. With the introduction of user namespaces sending out uevents
> became
> >> partially isolated as they were filtered by user namespaces:
> >>
> >> net/netlink/af_netlink.c:do_one_broadcast()
> >>
> >> if (!net_eq(sock_net(sk), p->net)) {
> >>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
> >>                 return;
> >>
> >>         if (!peernet_has_id(sock_net(sk), p->net))
> >>                 return;
> >>
> >>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >>                              CAP_NET_BROADCAST))
> >>         j       return;
> >> }
> >>
> >> The file_ns_capable() check will check whether the caller had
> >> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> >> namespace of interest. This check is fine in general but seems
> insufficient
> >> to me when paired with uevents. The reason is that devices always
> belong to
> >> the initial user namespace so uevents for kobjects that do not carry a
> >> namespace tag should never be sent into another user namespace. This has
> >> been the intention all along. But there's one case where this breaks,
> >> namely if a new user namespace is created by root on the host and an
> >> identity mapping is established between root on the host and root in the
> >> new user namespace. Here's a reproducer:
> >>
> >>  sudo unshare -U --map-root
> >>  udevadm monitor -k
> >>  # Now change to initial user namespace and e.g. do
> >>  modprobe kvm
> >>  # or
> >>  rmmod kvm
> >>
> >> will allow the non-initial user namespace to retrieve all uevents from
> the
> >> host. This seems very anecdotal given that in the general case user
> >> namespaces do not see any uevents and also can't really do anything
> useful
> >> with them.
> >>
> >> Additionally, it is now possible to send uevents from userspace. As
> such we
> >> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> >> namespace of the network namespace of the netlink socket) userspace
> process
> >> make a decision what uevents should be sent.
> >>
> >> This makes me think that we should simply ensure that uevents for
> kobjects
> >> that do not carry a namespace tag are *always* filtered by user
> namespace
> >> in kobj_bcast_filter(). Specifically:
> >> - If the owning user namespace of the uevent socket is not init_user_ns
> the
> >>   event will always be filtered.
> >> - If the network namespace the uevent socket belongs to was created in
> the
> >>   initial user namespace but was opened from a non-initial user
> namespace
> >>   the event will be filtered as well.
> >> Put another way, uevents for kobjects not carrying a namespace tag are
> now
> >> always only sent to the initial user namespace. The regression potential
> >> for this is near to non-existent since user namespaces can't really do
> >> anything with interesting devices.
> >>
> >> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > That was supposed to be [PATCH net] not [PATCH net-next] which is
> > obviously closed. Sorry about that.
>
> This does not appear to be a fix.
> This looks like feature work.
> The motivation appears to be that looks wrong let's change it.
>

Hm, sure looks like a bug to me though. But I'm happy to leave this for
net-next. I don't want to rush things if this change in semantics is
non-trivial.

David, is it ok to queue this or would you prefer I resend when net-next
reopens?


> So let's please leave this for when net-next opens again so we can
> have time to fully consider a change in semantics.
>

Sure. Any thoughts on whether this approach makes sense?

Thanks!
Christian


> Thank you,
> Eric
>

--001a114780aca6155405690fd7aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, =
Apr 5, 2018, 00:39 Eric W. Biederman &lt;<a href=3D"mailto:ebiederm@xmissio=
n.com">ebiederm@xmission.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Christian Brauner &lt;<a href=3D"mailto:christian.brauner@canonica=
l.com" target=3D"_blank" rel=3D"noreferrer">christian.brauner@canonical.com=
</a>&gt; writes:<br>
<br>
&gt; On Wed, Apr 04, 2018 at 09:48:57PM +0200, Christian Brauner wrote:<br>
&gt;&gt; commit 07e98962fa77 (&quot;kobject: Send hotplug events in all net=
work namespaces&quot;)<br>
&gt;&gt;<br>
&gt;&gt; enabled sending hotplug events into all network namespaces back in=
 2010.<br>
&gt;&gt; Over time the set of uevents that get sent into all network namesp=
aces has<br>
&gt;&gt; shrunk. We have now reached the point where hotplug events for all=
 devices<br>
&gt;&gt; that carry a namespace tag are filtered according to that namespac=
e.<br>
&gt;&gt;<br>
&gt;&gt; Specifically, they are filtered whenever the namespace tag of the =
kobject<br>
&gt;&gt; does not match the namespace tag of the netlink socket. One exampl=
e are<br>
&gt;&gt; network devices. Uevents for network devices only show up in the n=
etwork<br>
&gt;&gt; namespaces these devices are moved to or created in.<br>
&gt;&gt;<br>
&gt;&gt; However, any uevent for a kobject that does not have a namespace t=
ag<br>
&gt;&gt; associated with it will not be filtered and we will *try* to broad=
cast it<br>
&gt;&gt; into all network namespaces.<br>
&gt;&gt;<br>
&gt;&gt; The original patchset was written in 2010 before user namespaces w=
ere a<br>
&gt;&gt; thing. With the introduction of user namespaces sending out uevent=
s became<br>
&gt;&gt; partially isolated as they were filtered by user namespaces:<br>
&gt;&gt;<br>
&gt;&gt; net/netlink/af_netlink.c:do_one_broadcast()<br>
&gt;&gt;<br>
&gt;&gt; if (!net_eq(sock_net(sk), p-&gt;net)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(nlk-&gt;flags &amp; NETLINK=
_F_LISTEN_ALL_NSID))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!peernet_has_id(sock_net(sk),=
 p-&gt;net))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!file_ns_capable(sk-&gt;sk_so=
cket-&gt;file, p-&gt;net-&gt;user_ns,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CAP_NET_BROADCAST))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n;<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; The file_ns_capable() check will check whether the caller had<br>
&gt;&gt; CAP_NET_BROADCAST at the time of opening the netlink socket in the=
 user<br>
&gt;&gt; namespace of interest. This check is fine in general but seems ins=
ufficient<br>
&gt;&gt; to me when paired with uevents. The reason is that devices always =
belong to<br>
&gt;&gt; the initial user namespace so uevents for kobjects that do not car=
ry a<br>
&gt;&gt; namespace tag should never be sent into another user namespace. Th=
is has<br>
&gt;&gt; been the intention all along. But there&#39;s one case where this =
breaks,<br>
&gt;&gt; namely if a new user namespace is created by root on the host and =
an<br>
&gt;&gt; identity mapping is established between root on the host and root =
in the<br>
&gt;&gt; new user namespace. Here&#39;s a reproducer:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 sudo unshare -U --map-root<br>
&gt;&gt;=C2=A0 udevadm monitor -k<br>
&gt;&gt;=C2=A0 # Now change to initial user namespace and e.g. do<br>
&gt;&gt;=C2=A0 modprobe kvm<br>
&gt;&gt;=C2=A0 # or<br>
&gt;&gt;=C2=A0 rmmod kvm<br>
&gt;&gt;<br>
&gt;&gt; will allow the non-initial user namespace to retrieve all uevents =
from the<br>
&gt;&gt; host. This seems very anecdotal given that in the general case use=
r<br>
&gt;&gt; namespaces do not see any uevents and also can&#39;t really do any=
thing useful<br>
&gt;&gt; with them.<br>
&gt;&gt;<br>
&gt;&gt; Additionally, it is now possible to send uevents from userspace. A=
s such we<br>
&gt;&gt; can let a sufficiently privileged (CAP_SYS_ADMIN in the owning use=
r<br>
&gt;&gt; namespace of the network namespace of the netlink socket) userspac=
e process<br>
&gt;&gt; make a decision what uevents should be sent.<br>
&gt;&gt;<br>
&gt;&gt; This makes me think that we should simply ensure that uevents for =
kobjects<br>
&gt;&gt; that do not carry a namespace tag are *always* filtered by user na=
mespace<br>
&gt;&gt; in kobj_bcast_filter(). Specifically:<br>
&gt;&gt; - If the owning user namespace of the uevent socket is not init_us=
er_ns the<br>
&gt;&gt;=C2=A0 =C2=A0event will always be filtered.<br>
&gt;&gt; - If the network namespace the uevent socket belongs to was create=
d in the<br>
&gt;&gt;=C2=A0 =C2=A0initial user namespace but was opened from a non-initi=
al user namespace<br>
&gt;&gt;=C2=A0 =C2=A0the event will be filtered as well.<br>
&gt;&gt; Put another way, uevents for kobjects not carrying a namespace tag=
 are now<br>
&gt;&gt; always only sent to the initial user namespace. The regression pot=
ential<br>
&gt;&gt; for this is near to non-existent since user namespaces can&#39;t r=
eally do<br>
&gt;&gt; anything with interesting devices.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian Brauner &lt;<a href=3D"mailto:christian.b=
rauner@ubuntu.com" target=3D"_blank" rel=3D"noreferrer">christian.brauner@u=
buntu.com</a>&gt;<br>
&gt;<br>
&gt; That was supposed to be [PATCH net] not [PATCH net-next] which is<br>
&gt; obviously closed. Sorry about that.<br>
<br>
This does not appear to be a fix.<br>
This looks like feature work.<br>
The motivation appears to be that looks wrong let&#39;s change it.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Hm, sure =
looks like a bug to me though. But I&#39;m happy to leave this for net-next=
. I don&#39;t want to rush things if this change in semantics is non-trivia=
l.</div><div dir=3D"auto"><br></div><div dir=3D"auto">David, is it ok to qu=
eue this or would you prefer I resend when net-next reopens?</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
So let&#39;s please leave this for when net-next opens again so we can<br>
have time to fully consider a change in semantics.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Sure. Any thoughts on whe=
ther this approach makes sense?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks!</div><div dir=3D"auto">Christian</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<br>
Thank you,<br>
Eric<br>
</blockquote></div></div></div>

--001a114780aca6155405690fd7aa--
