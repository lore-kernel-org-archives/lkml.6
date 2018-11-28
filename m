Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB72B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEvKl/0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB72B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeK2A6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeK2A6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:58:30 -0500
Received: from quaco.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6821E2086B;
        Wed, 28 Nov 2018 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543413404;
        bh=5IbKaFUWIYu8tST7stsLMVnJDvzRfMXmpFwOZnPDJ9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEvKl/0HxvP9n0HaCbAcWjoiyCgJmJ31iY07M0SyOPRLHl9CfAbiawAP7iahCk5jR
         QRdbG8tstC0pI8tCCfAqXOerCbi4IDfAqCgAVwq2ISnt83rxw9LkJdDC6EY2PEIk1y
         hFGP4tQz2qYj1kA/RCKzP+SaAhmiCn+IUmr5sYA0=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id E37EA40341; Wed, 28 Nov 2018 10:56:41 -0300 (-03)
Date:   Wed, 28 Nov 2018 10:56:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCHv2 01/10] tools lib traceevent: Use LDFLAGS in the build
 commands
Message-ID: <20181128135641.GD31608@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-2-jolsa@kernel.org>
 <20181016112136.3a72a452@gandalf.local.home>
 <20181016154526.GC6631@krava>
 <20181017102341.53412998@gandalf.local.home>
 <20181116130158.GA30583@krava>
 <20181122093006.GD15953@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181122093006.GD15953@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 10:30:06AM +0100, Jiri Olsa escreveu:
> On Fri, Nov 16, 2018 at 02:01:58PM +0100, Jiri Olsa wrote:
> > On Wed, Oct 17, 2018 at 10:23:41AM -0400, Steven Rostedt wrote:
> > > On Tue, 16 Oct 2018 17:45:26 +0200
> > > Jiri Olsa <jolsa@redhat.com> wrote:
> > >=20
> > > > On Tue, Oct 16, 2018 at 11:21:36AM -0400, Steven Rostedt wrote:
> > > > > On Tue, 16 Oct 2018 17:06:06 +0200
> > > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >  =20
> > > > > > So user could specify outside LDFLAGS values.
> > > > > >=20
> > > > > > Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > ---
> > > > > >  tools/lib/traceevent/Makefile | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceeve=
nt/Makefile
> > > > > > index 0b4e833088a4..e535073c94ce 100644
> > > > > > --- a/tools/lib/traceevent/Makefile
> > > > > > +++ b/tools/lib/traceevent/Makefile
> > > > > > @@ -174,7 +174,7 @@ $(TE_IN): force
> > > > > >  	$(Q)$(MAKE) $(build)=3Dlibtraceevent
> > > > > > =20
> > > > > >  $(OUTPUT)libtraceevent.so.$(EVENT_PARSE_VERSION): $(TE_IN)
> > > > > > -	$(QUIET_LINK)$(CC) --shared $^ -Wl,-soname,libtraceevent.so.$=
(EP_VERSION) -o $@
> > > > > > +	$(QUIET_LINK)$(CC) --shared $(LDFLAGS) $^ -Wl,-soname,libtrac=
eevent.so.$(EP_VERSION) -o $@
> > > > > >  	@ln -sf $(@F) $(OUTPUT)libtraceevent.so
> > > > > >  	@ln -sf $(@F) $(OUTPUT)libtraceevent.so.$(EP_VERSION)
> > > > > > =20
> > > > > > @@ -193,7 +193,7 @@ $(PLUGINS_IN): force
> > > > > >  	$(Q)$(MAKE) $(build)=3D$(plugin_obj)
> > > > > > =20
> > > > > >  $(OUTPUT)%.so: $(OUTPUT)%-in.o
> > > > > > -	$(QUIET_LINK)$(CC) $(CFLAGS) -shared -nostartfiles -o $@ $^
> > > > > > +	$(QUIET_LINK)$(CC) -shared $(LDFLAGS) -nostartfiles -o $@ $^ =
=20
> > > > >=20
> > > > >=20
> > > > > I'm guessing that the CFLAGS are not needed here, but shouldn't t=
hat
> > > > > also be mentioned in the change log? =20
> > > >=20
> > > > yep, sry.. v2 attached
> > > >=20
> > >=20
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >=20
> > Arnaldo,
> > could you pull in this one?
>=20
> ping, thanks

   9    11.28 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gc=
c (GCC) 4.9.x 20150123 (prerelease)
  10    15.53 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gc=
c (GCC) 4.9.x 20150123 (prerelease)

    LD       /tmp/build/perf/libtraceevent-in.o
  MKDIR    /tmp/build/perf/util/
  LINK     /tmp/build/perf/libtraceevent.a
  CC       /tmp/build/perf/util/block-range.o
  MKDIR    /tmp/build/perf/arch/
  CC       /tmp/build/perf/arch/common.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_function-in.o
  CC       /tmp/build/perf/plugin_xen.o
  MKDIR    /tmp/build/perf/arch/arm/util/
  CC       /tmp/build/perf/arch/arm/util/pmu.o
  LD       /tmp/build/perf/plugin_xen-in.o
  CC       /tmp/build/perf/plugin_scsi.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  MKDIR    /tmp/build/perf/arch/arm/util/
  CC       /tmp/build/perf/arch/arm/util/auxtrace.o
  CC       /tmp/build/perf/arch/arm/util/cs-etm.o
  LINK     /tmp/build/perf/plugin_jbd2.so
/opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x=
86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-andr=
oideabi/bin/ld: error: cannot find -lc
/opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x=
86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-andr=
oideabi/bin/ld: error: cannot find -ldl
collect2: error: ld returned 1 exit status
Makefile:196: recipe for target '/tmp/build/perf/plugin_jbd2.so' failed
make[3]: *** [/tmp/build/perf/plugin_jbd2.so] Error 1
Makefile.perf:669: recipe for target 'libtraceevent_plugins' failed
make[2]: *** [libtraceevent_plugins] Error 2
make[2]: *** Waiting for unfinished jobs....


[root@seventh fedora]# cat /tmp/dm.log*/android*12*
android-ndk:r12b-arm
Downloading http://192.168.86.9/perf/perf-4.20.0-rc3.tar.xz...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
100 1423k  100 1423k    0     0  71.4M      0 --:--:-- --:--:-- --:--:-- 77=
=2E2M
e1326b0cc430443c4560ff3079c8c10159743ae5
Using built-in specs.
COLLECT_GCC=3D/opt/android-ndk-r12b//toolchains/arm-linux-androideabi-4.9/p=
rebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc
COLLECT_LTO_WRAPPER=3D/opt/android-ndk-r12b/toolchains/arm-linux-androideab=
i-4.9/prebuilt/linux-x86_64/bin/../libexec/gcc/arm-linux-androideabi/4.9.x/=
lto-wrapper
Target: arm-linux-androideabi
Configured with: /usr/local/google/buildbot/src/android/gcc/toolchain/build=
/../gcc/gcc-4.9/configure --prefix=3D/tmp/59719db9ae19ff43aef46bbcb79596b6 =
--target=3Darm-linux-androideabi --host=3Dx86_64-linux-gnu --build=3Dx86_64=
-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=3Dc,c++ --with-gm=
p=3D/buildbot/tmp/build/toolchain/temp-install --with-mpfr=3D/buildbot/tmp/=
build/toolchain/temp-install --with-mpc=3D/buildbot/tmp/build/toolchain/tem=
p-install --with-cloog=3D/buildbot/tmp/build/toolchain/temp-install --with-=
isl=3D/buildbot/tmp/build/toolchain/temp-install --with-ppl=3D/buildbot/tmp=
/build/toolchain/temp-install --disable-ppl-version-check --disable-cloog-v=
ersion-check --disable-isl-version-check --enable-cloog-backend=3Disl --wit=
h-host-libstdcxx=3D'-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --d=
isable-libssp --enable-threads --disable-nls --disable-libmudflap --disable=
-libgomp --disable-libstdc__-v3 --disable-sjlj-exceptions --disable-shared =
--disable-tls --disable-libitm --with-float=3Dsoft --with-fpu=3Dvfp --with-=
arch=3Darmv5te --enable-target-optspace --enable-bionic-libs --enable-libat=
omic-ifuncs=3Dno --enable-initfini-array --disable-nls --prefix=3D/tmp/5971=
9db9ae19ff43aef46bbcb79596b6 --with-sysroot=3D/tmp/59719db9ae19ff43aef46bbc=
b79596b6/sysroot --with-binutils-version=3D2.25 --with-mpfr-version=3D3.1.1=
 --with-mpc-version=3D1.0.1 --with-gmp-version=3D5.0.5 --with-gcc-version=
=3D4.9 --with-gdb-version=3Dnone --with-gxx-include-dir=3D/tmp/59719db9ae19=
ff43aef46bbcb79596b6/include/c++/4.9.x --with-bugurl=3Dhttp://source.androi=
d.com/source/report-bugs.html --enable-languages=3Dc,c++ --disable-bootstra=
p --enable-plugins --enable-libgomp --enable-gnu-indirect-function --disabl=
e-libsanitizer --enable-gold --enable-threads --enable-eh-frame-hdr-for-sta=
tic --enable-graphite=3Dyes --with-isl-version=3D0.11.1 --with-cloog-versio=
n=3D0.18.0 --with-arch=3Darmv5te --program-transform-name=3D's&^&arm-linux-=
androideabi-&' --enable-gold=3Ddefault
Thread model: posix
gcc version 4.9.x 20150123 (prerelease) (GCC)
make: Entering directory '/git/linux/tools/perf'

Without it, so far:

   1    59.08 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2    68.75 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1=
 20160822
   3    79.67 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4    48.69 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5    46.89 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6    46.46 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   7    38.46 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623=
 (Red Hat 4.8.5-28)
   8    44.69 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303=
 (Red Hat 7.3.1-5)
   9    41.88 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gc=
c (GCC) 4.9.x 20150123 (prerelease)
  10    46.24 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gc=
c (GCC) 4.9.x 20150123 (prerelease)
  11    22.22 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704=
 (Red Hat 4.1.2-55)
  12    35.54 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313=
 (Red Hat 4.4.7-23)

- Arnaldo
