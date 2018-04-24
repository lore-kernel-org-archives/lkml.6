Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZprhKm8kXY7d0g6zNJiDsfuOZ1FwwVrUsGZ3caILvsCZzi2mf7ik2/INmX8qTgymEiuYBjZ
ARC-Seal: i=1; a=rsa-sha256; t=1524610070; cv=none;
        d=google.com; s=arc-20160816;
        b=PgoJcsMFSPb2fDMbWY/IJpOKbj2ZRp0YpgtPStYV9REm8Qbbnii791c+oQLz8HIrkr
         5MWls/0e7l7FD/VKa39Y7EMBPUxlfrtwgWMSTKp1pFLPxfnpMTeGEgjwYm+EnqxVHHds
         lqDCB2ZNk2mQqNmaKkhSuX+ypzeWpxF89LW//2/B/CtSu8Th71o4ZKVeYKGrNcsDoYbV
         RNy0+6k9Au7JrIHISS0qWra2F+7cXn6bcHn6NNbmbG5f08attBCUHcHGZH14Bk6zmRZr
         Da5VOMDMTPEu/5Zt5LBZUpOWF/DUri8+/J8kcoxY9VhpLa2TyqRCg8lmC4nHvE5qdmBL
         MEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:arc-authentication-results;
        bh=WwyFEZDvNhPrPJLIQUJ/vRYjiDYnwtFxOfKQCyTRSNM=;
        b=bm/mq/VTrO2vmwDrVPqmwcsVO4uklNsK5rAR6e3N0ge0uCczkShWEkbRQOCM5ojEIA
         Ee6oCu+4om+rhSm0eHAaKUS92+1bbEFTLncGWZ9h3vbm+eSQQOuR03EAiWPFxyJs0QtO
         QxOwcqO3ue31lVtGqMUy+ztgQnBh8ZnfA3/0Znv4yX3OdHZurnO6ATjVdzE8772T9iyy
         Y/Z8fqQeZCWHVGra+dAHmJVkr0Cz+7CShz/8I5/NBBwbiJMeNMXz+Vqmtcz97C57HLxa
         FKsr9cXl8W1j3V3qUAwQ2Q5H4wF70mdHJBH/CneDs7tPavbxiKijOjJQI7mN8QhGEn3F
         p9xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
MIME-Version: 1.0
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
 <20180424204335.12904-2-christian.brauner@ubuntu.com> <87po2oz0s8.fsf@xmission.com>
In-Reply-To: <87po2oz0s8.fsf@xmission.com>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Tue, 24 Apr 2018 22:47:37 +0000
Message-ID: <CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Content-Type: multipart/alternative; boundary="001a11436f408f7384056a9ff1c1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598669529517561428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11436f408f7384056a9ff1c1
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:

>
> Bah.  This code is obviously correct and probably wrong.
>
> How do we deliver uevents for network devices that are outside of the
> initial user namespace?  The kernel still needs to deliver those.
>
> The logic to figure out which network namespace a device needs to be
> delivered to is is present in kobj_bcast_filter.  That logic will almost
> certainly need to be turned inside out.  Sign not as easy as I would
> have hoped.


My first patch that we discussed put additional filtering logic into
kobj_bcast_filter for that very reason. But I can move that logic out and
come up with a new patch.


> Eric
>
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> > commit 07e98962fa77 ("kobject: Send hotplug events in all network
> namespaces")
> >
> > enabled sending hotplug events into all network namespaces back in 2010.
> > Over time the set of uevents that get sent into all network namespaces
> has
> > shrunk a little. We have now reached the point where hotplug events for
> all
> > devices that carry a namespace tag are filtered according to that
> > namespace. Specifically, they are filtered whenever the namespace tag of
> > the kobject does not match the namespace tag of the netlink socket. One
> > example are network devices. Uevents for network devices only show up in
> > the network namespaces these devices are moved to or created in.
> >
> > However, any uevent for a kobject that does not have a namespace tag
> > associated with it will not be filtered and we will broadcast it into all
> > network namespaces. This behavior stopped making sense when user
> namespaces
> > were introduced.
> >
> > This patch restricts uevents to the initial user namespace for a couple
> of
> > reasons that have been extensively discusses on the mailing list [1].
> > - Thundering herd:
> >   Broadcasting uevents into all network namespaces introduces significant
> >   overhead.
> >   All processes that listen to uevents running in non-initial user
> >   namespaces will end up responding to uevents that will be meaningless
> to
> >   them. Mainly, because non-initial user namespaces cannot easily manage
> >   devices unless they have a privileged host-process helping them out.
> This
> >   means that there will be a thundering herd of activity when there
> >   shouldn't be any.
> > - Uevents from non-root users are already filtered in userspace:
> >   Uevents are filtered by userspace in a user namespace because the
> >   received uid != 0. Instead the uid associated with the event will be
> >   65534 == "nobody" because the global root uid is not mapped.
> >   This means we can safely and without introducing regressions modify the
> >   kernel to not send uevents into all network namespaces whose owning
> user
> >   namespace is not the initial user namespace because we know that
> >   userspace will ignore the message because of the uid anyway. I have
> >   a) verified that is is true for every udev implementation out there b)
> >   that this behavior has been present in all udev implementations from
> the
> >   very beginning.
> > - Removing needless overhead/Increasing performance:
> >   Currently, the uevent socket for each network namespace is added to the
> >   global variable uevent_sock_list. The list itself needs to be protected
> >   by a mutex. So everytime a uevent is generated the mutex is taken on
> the
> >   list. The mutex is held *from the creation of the uevent (memory
> >   allocation, string creation etc. until all uevent sockets have been
> >   handled*. This is aggravated by the fact that for each uevent socket
> that
> >   has listeners the mc_list must be walked as well which means we're
> >   talking O(n^2) here. Given that a standard Linux workload usually has
> >   quite a lot of network namespaces and - in the face of containers - a
> lot
> >   of user namespaces this quickly becomes a performance problem (see
> >   "Thundering herd" above). By just recording uevent sockets of network
> >   namespaces that are owned by the initial user namespace we
> significantly
> >   increase performance in this codepath.
> > - Injecting uevents:
> >   There's a valid argument that containers might be interested in
> receiving
> >   device events especially if they are delegated to them by a privileged
> >   userspace process. One prime example are SR-IOV enabled devices that
> are
> >   explicitly designed to be handed of to other users such as VMs or
> >   containers.
> >   This use-case can now be correctly handled since
> >   commit 692ec06d7c92 ("netns: send uevent messages"). This commit
> >   introduced the ability to send uevents from userspace. As such we can
> let
> >   a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace
> of
> >   the network namespace of the netlink socket) userspace process make a
> >   decision what uevents should be sent. This removes the need to blindly
> >   broadcast uevents into all user namespaces and provides a performant
> and
> >   safe solution to this problem.
> > - Filtering logic:
> >   This patch filters by *owning user namespace of the network namespace a
> >   given task resides in* and not by user namespace of the task per se.
> This
> >   means if the user namespace of a given task is unshared but the network
> >   namespace is kept and is owned by the initial user namespace a listener
> >   that is opening the uevent socket in that network namespace can still
> >   listen to uevents.
> >
> > [1]: https://lkml.org/lkml/2018/4/4/739
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > Changelog v1->v2:
> > * patch unchanged
> > Changelog v0->v1:
> > * patch unchanged
> > ---
> >  lib/kobject_uevent.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 15ea216a67ce..f5f5038787ac 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
> >
> >       net->uevent_sock = ue_sk;
> >
> > -     mutex_lock(&uevent_sock_mutex);
> > -     list_add_tail(&ue_sk->list, &uevent_sock_list);
> > -     mutex_unlock(&uevent_sock_mutex);
> > +     /* Restrict uevents to initial user namespace. */
> > +     if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> > +             mutex_lock(&uevent_sock_mutex);
> > +             list_add_tail(&ue_sk->list, &uevent_sock_list);
> > +             mutex_unlock(&uevent_sock_mutex);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
> >  {
> >       struct uevent_sock *ue_sk = net->uevent_sock;
> >
> > -     mutex_lock(&uevent_sock_mutex);
> > -     list_del(&ue_sk->list);
> > -     mutex_unlock(&uevent_sock_mutex);
> > +     if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> > +             mutex_lock(&uevent_sock_mutex);
> > +             list_del(&ue_sk->list);
> > +             mutex_unlock(&uevent_sock_mutex);
> > +     }
> >
> >       netlink_kernel_release(ue_sk->sk);
> >       kfree(ue_sk);
>

--001a11436f408f7384056a9ff1c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, =
Apr 25, 2018, 00:41 Eric W. Biederman &lt;<a href=3D"mailto:ebiederm@xmissi=
on.com">ebiederm@xmission.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><br>
Bah.=C2=A0 This code is obviously correct and probably wrong.<br>
<br>
How do we deliver uevents for network devices that are outside of the<br>
initial user namespace?=C2=A0 The kernel still needs to deliver those.<br>
<br>
The logic to figure out which network namespace a device needs to be<br>
delivered to is is present in kobj_bcast_filter.=C2=A0 That logic will almo=
st<br>
certainly need to be turned inside out.=C2=A0 Sign not as easy as I would<b=
r>
have hoped.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">My first patch that we discussed put additional filtering logic into=
 kobj_bcast_filter for that very reason. But I can move that logic out and =
come up with a new patch.</div><div dir=3D"auto"></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
Eric<br>
<br>
Christian Brauner &lt;<a href=3D"mailto:christian.brauner@ubuntu.com" targe=
t=3D"_blank" rel=3D"noreferrer">christian.brauner@ubuntu.com</a>&gt; writes=
:<br>
&gt; commit 07e98962fa77 (&quot;kobject: Send hotplug events in all network=
 namespaces&quot;)<br>
&gt;<br>
&gt; enabled sending hotplug events into all network namespaces back in 201=
0.<br>
&gt; Over time the set of uevents that get sent into all network namespaces=
 has<br>
&gt; shrunk a little. We have now reached the point where hotplug events fo=
r all<br>
&gt; devices that carry a namespace tag are filtered according to that<br>
&gt; namespace. Specifically, they are filtered whenever the namespace tag =
of<br>
&gt; the kobject does not match the namespace tag of the netlink socket. On=
e<br>
&gt; example are network devices. Uevents for network devices only show up =
in<br>
&gt; the network namespaces these devices are moved to or created in.<br>
&gt;<br>
&gt; However, any uevent for a kobject that does not have a namespace tag<b=
r>
&gt; associated with it will not be filtered and we will broadcast it into =
all<br>
&gt; network namespaces. This behavior stopped making sense when user names=
paces<br>
&gt; were introduced.<br>
&gt;<br>
&gt; This patch restricts uevents to the initial user namespace for a coupl=
e of<br>
&gt; reasons that have been extensively discusses on the mailing list [1].<=
br>
&gt; - Thundering herd:<br>
&gt;=C2=A0 =C2=A0Broadcasting uevents into all network namespaces introduce=
s significant<br>
&gt;=C2=A0 =C2=A0overhead.<br>
&gt;=C2=A0 =C2=A0All processes that listen to uevents running in non-initia=
l user<br>
&gt;=C2=A0 =C2=A0namespaces will end up responding to uevents that will be =
meaningless to<br>
&gt;=C2=A0 =C2=A0them. Mainly, because non-initial user namespaces cannot e=
asily manage<br>
&gt;=C2=A0 =C2=A0devices unless they have a privileged host-process helping=
 them out. This<br>
&gt;=C2=A0 =C2=A0means that there will be a thundering herd of activity whe=
n there<br>
&gt;=C2=A0 =C2=A0shouldn&#39;t be any.<br>
&gt; - Uevents from non-root users are already filtered in userspace:<br>
&gt;=C2=A0 =C2=A0Uevents are filtered by userspace in a user namespace beca=
use the<br>
&gt;=C2=A0 =C2=A0received uid !=3D 0. Instead the uid associated with the e=
vent will be<br>
&gt;=C2=A0 =C2=A065534 =3D=3D &quot;nobody&quot; because the global root ui=
d is not mapped.<br>
&gt;=C2=A0 =C2=A0This means we can safely and without introducing regressio=
ns modify the<br>
&gt;=C2=A0 =C2=A0kernel to not send uevents into all network namespaces who=
se owning user<br>
&gt;=C2=A0 =C2=A0namespace is not the initial user namespace because we kno=
w that<br>
&gt;=C2=A0 =C2=A0userspace will ignore the message because of the uid anywa=
y. I have<br>
&gt;=C2=A0 =C2=A0a) verified that is is true for every udev implementation =
out there b)<br>
&gt;=C2=A0 =C2=A0that this behavior has been present in all udev implementa=
tions from the<br>
&gt;=C2=A0 =C2=A0very beginning.<br>
&gt; - Removing needless overhead/Increasing performance:<br>
&gt;=C2=A0 =C2=A0Currently, the uevent socket for each network namespace is=
 added to the<br>
&gt;=C2=A0 =C2=A0global variable uevent_sock_list. The list itself needs to=
 be protected<br>
&gt;=C2=A0 =C2=A0by a mutex. So everytime a uevent is generated the mutex i=
s taken on the<br>
&gt;=C2=A0 =C2=A0list. The mutex is held *from the creation of the uevent (=
memory<br>
&gt;=C2=A0 =C2=A0allocation, string creation etc. until all uevent sockets =
have been<br>
&gt;=C2=A0 =C2=A0handled*. This is aggravated by the fact that for each uev=
ent socket that<br>
&gt;=C2=A0 =C2=A0has listeners the mc_list must be walked as well which mea=
ns we&#39;re<br>
&gt;=C2=A0 =C2=A0talking O(n^2) here. Given that a standard Linux workload =
usually has<br>
&gt;=C2=A0 =C2=A0quite a lot of network namespaces and - in the face of con=
tainers - a lot<br>
&gt;=C2=A0 =C2=A0of user namespaces this quickly becomes a performance prob=
lem (see<br>
&gt;=C2=A0 =C2=A0&quot;Thundering herd&quot; above). By just recording ueve=
nt sockets of network<br>
&gt;=C2=A0 =C2=A0namespaces that are owned by the initial user namespace we=
 significantly<br>
&gt;=C2=A0 =C2=A0increase performance in this codepath.<br>
&gt; - Injecting uevents:<br>
&gt;=C2=A0 =C2=A0There&#39;s a valid argument that containers might be inte=
rested in receiving<br>
&gt;=C2=A0 =C2=A0device events especially if they are delegated to them by =
a privileged<br>
&gt;=C2=A0 =C2=A0userspace process. One prime example are SR-IOV enabled de=
vices that are<br>
&gt;=C2=A0 =C2=A0explicitly designed to be handed of to other users such as=
 VMs or<br>
&gt;=C2=A0 =C2=A0containers.<br>
&gt;=C2=A0 =C2=A0This use-case can now be correctly handled since<br>
&gt;=C2=A0 =C2=A0commit 692ec06d7c92 (&quot;netns: send uevent messages&quo=
t;). This commit<br>
&gt;=C2=A0 =C2=A0introduced the ability to send uevents from userspace. As =
such we can let<br>
&gt;=C2=A0 =C2=A0a sufficiently privileged (CAP_SYS_ADMIN in the owning use=
r namespace of<br>
&gt;=C2=A0 =C2=A0the network namespace of the netlink socket) userspace pro=
cess make a<br>
&gt;=C2=A0 =C2=A0decision what uevents should be sent. This removes the nee=
d to blindly<br>
&gt;=C2=A0 =C2=A0broadcast uevents into all user namespaces and provides a =
performant and<br>
&gt;=C2=A0 =C2=A0safe solution to this problem.<br>
&gt; - Filtering logic:<br>
&gt;=C2=A0 =C2=A0This patch filters by *owning user namespace of the networ=
k namespace a<br>
&gt;=C2=A0 =C2=A0given task resides in* and not by user namespace of the ta=
sk per se. This<br>
&gt;=C2=A0 =C2=A0means if the user namespace of a given task is unshared bu=
t the network<br>
&gt;=C2=A0 =C2=A0namespace is kept and is owned by the initial user namespa=
ce a listener<br>
&gt;=C2=A0 =C2=A0that is opening the uevent socket in that network namespac=
e can still<br>
&gt;=C2=A0 =C2=A0listen to uevents.<br>
&gt;<br>
&gt; [1]: <a href=3D"https://lkml.org/lkml/2018/4/4/739" rel=3D"noreferrer =
noreferrer" target=3D"_blank">https://lkml.org/lkml/2018/4/4/739</a><br>
&gt; Signed-off-by: Christian Brauner &lt;<a href=3D"mailto:christian.braun=
er@ubuntu.com" target=3D"_blank" rel=3D"noreferrer">christian.brauner@ubunt=
u.com</a>&gt;<br>
&gt; ---<br>
&gt; Changelog v1-&gt;v2:<br>
&gt; * patch unchanged<br>
&gt; Changelog v0-&gt;v1:<br>
&gt; * patch unchanged<br>
&gt; ---<br>
&gt;=C2=A0 lib/kobject_uevent.c | 18 ++++++++++++------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c<br>
&gt; index 15ea216a67ce..f5f5038787ac 100644<br>
&gt; --- a/lib/kobject_uevent.c<br>
&gt; +++ b/lib/kobject_uevent.c<br>
&gt; @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0net-&gt;uevent_sock =3D ue_sk;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;uevent_sock_mutex);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;ue_sk-&gt;list, &amp;uevent_so=
ck_list);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;uevent_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Restrict uevents to initial user namespace. */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (sock_net(ue_sk-&gt;sk)-&gt;user_ns =3D=3D &am=
p;init_user_ns) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ueven=
t_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;ue=
_sk-&gt;list, &amp;uevent_sock_list);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;uev=
ent_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct uevent_sock *ue_sk =3D net-&gt;uevent=
_sock;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;uevent_sock_mutex);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0list_del(&amp;ue_sk-&gt;list);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;uevent_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (sock_net(ue_sk-&gt;sk)-&gt;user_ns =3D=3D &am=
p;init_user_ns) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ueven=
t_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;ue_sk-&=
gt;list);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;uev=
ent_sock_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0netlink_kernel_release(ue_sk-&gt;sk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ue_sk);<br>
</blockquote></div></div></div>

--001a11436f408f7384056a9ff1c1--
