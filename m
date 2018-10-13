Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09413C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A020693
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJNDYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 23:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbeJNDYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 23:24:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEDEE88304;
        Sat, 13 Oct 2018 19:45:54 +0000 (UTC)
Received: from redhat.com (ovpn-117-170.phx2.redhat.com [10.3.117.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4FD601A1;
        Sat, 13 Oct 2018 19:45:54 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.90_1)
        (envelope-from <fche@redhat.com>)
        id 1gBPrF-00047n-1U; Sat, 13 Oct 2018 15:45:53 -0400
Date:   Sat, 13 Oct 2018 15:45:52 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     systemtap@sourceware.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 4.0 release
Message-ID: <20181013194552.GA15673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 13 Oct 2018 19:45:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.0!

prometheus exporter network service; ebpf support extensions including
strings and implementation of traditional log(), sprintf() functions;
rebuilt rich tapset coverage for 4.17+ syscalls and for
tracepoint-based syscalls; script language tweaks for supporting
machine-generated scripts


= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.0 (commit 428f84e9e656b)

  There have been over 250 commits since the last release.
  There have dozens of bugs fixed / features added since the last release.


= SystemTap frontend (stap) changes

- A new network service, stap-exporter, is included.  It glues
  systemtap and the web.  It allows a prometheus (or compatible
  systems such as pcp) to consume metrics exported by systemtap
  scripts.  Some tapset macros/functions are available to make it
  easier to write such scripts.  See the stap-exporter(8) man page and
  the systemd service.

- Embedded-C functions marked /* guru */ may now be invoked from other
  tapset probes / functions, while still being invalid for normal call
  from an unprivileged user script.

- New script language operators @kderef/@uderef and @kregister/@uregister
  were added.
  @kderef/@uderef (size,address) can be used to dereference integers and
  @kregister/@uregister (dwarf#) can be used to access register values.

- The eBPF backend's string support has been improved. Strings
  can now be stored in variables, passed as function arguments,
  and stored as array keys and values.

- The 3rd operand of the ternary operator '?:' in the script language
  now binds tighter than the binary assignment operators like '=' and
  '+=', just like the C language. The original operator precedence can
  be restored by the '--compatible 3.3' option.

- The script language now supports the use of bare 'return' statements
  (without any return values) inside functions which do not return any
  values. A trailing semicolon is recommended for such return
  statements to avoid any potential ambiguity. The parser treats a
  following semicolon (';') or a closing curly bracket ('}') as a
  terminator for such bare return statements.

- Parentheses after unary '&' with a target-symbol expression is
  now accepted in the script language.

- A systemd service file has been added for systemtap.service (which
  runs a configurable set of scripts automatically on system
  startup). The existing /etc/init.d/systemtap init script has been
  moved to a new utility command 'systemtap-service' which preserves
  functionality such as configuring onboot systemtap scripts via
  dracut. See systemtap-service(8) for details.


= SystemTap backend changes

- Runtime/tapsets were ported to include up to kernel version 4.19-rc

- When a systemtap module is loaded, the name of the original stap script
  is now printed to dmesg by the kernel runtime.

- On some Fedora kernels, the information necessary to automatically
  engage in SecureBoot module signing is hidden from systemtap.
  Setting the $SYSTEMTAP_SIGN environment variable forces it on.
  A running stap-server instance will also be needed.

- The experimental ftrace ring buffer mechanism (STP_USE_RING_BUFFER)
  has been deprecated and may be removed in future versions.


= SystemTap tapset changes

- The syscall tapset is now updated to work on kernel 4.17+.
  Additionally, the tapset now includes an automatic fallback alias to
  the sys_enter / sys_exit kernel tracepoints, if no other
  kprobe-based mechanism is found.  These changes have brought
  unavoidable consequences.  Raw $target variables for the syscall
  arguments and return probes (e.g. @entry($fd), $return, returnval())
  may not longer be relied upon. Instead, use the variables defined by
  the tapset aliases.  For example:
  
     % stap -L syscall.read
     syscall.read name:string fd:long buf_uaddr:long count:long argstr:string
     % stap -L syscall.read.return
     syscall.read.return name:string retval:long retstr:string
     
  to see the available variables for that syscall.  See
  [man stapprobes] for further details.  returnval() in particular is
  being deprecated soon; use retval in syscall.*.return probes instead.

- Tapset functions register() and u_register() now support 8-bit
  x86 register names "ah", "al", "bh", "bl", "ch", "cl", "dh", and
  "dl" on both x86_64 and i386. And 16-bit x86 registers are now
  truly read as 16-bit integers instead of as 32-bit ones.

- Added a new abort() function that combines exit() and an immediate
  return from the current probe/function.


= SystemTap sample scripts

All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- New samples exporting data in Prometheus format:

also_ran.stp           Keep a tally of executables run on the system

cpu_throttle.stp       Monitor Intel processors for throttling
                       due to power or thermal limits

syscallsbypid.stp      Provide a per-process syscall tally on the system

syscallerrorsbypid.stp Provide a per-process syscall error tally

syscalllatency.stp     Provide a per-process accumulation of syscall latency

- New stap-exporter-scripts/ subdirectory in systemtap.examples.

- Numerous example script improvements and new samples galore:

gmalloc_watch.stp   Tracing glib2 memory allocations

ioctl_handler.stp   Monitor which executables use ioctl syscalls
                    and what kernel code is handling the ioctl

libguestfs_log.stp  Trace libguestfs startup

measureinterval.stp Measure intervals between events

php-trace.stp       Tracing of PHP code execution

stap_time.stp       Provide elapsed times for passes
                    of SystemTap script compilation

tcl-funtop.stp      Profile Tcl calls

tcl-trace.stp       Callgraph tracing of Tcl code

cve-2018-14634.stp  historical emergency security band-aid,
                    for reference/education only


= Examples of tested kernel versions

  2.6.32 (RHEL 6 x86_64, i686)
  3.10.0 (RHEL 7 x86_64)
  4.15.0 (Ubuntu 18.04 x86_64)
  4.16.13 (Fedora 28 x86_64)
  4.18.0 (Fedora x86_64)
  4.18.12 (Fedora 28 x86_64, arm64, ppc64)
  4.19-rc7 (Fedora Rawhide x86_64)


= Known issues with this release

- Some kernel crashes continue to be reported when a script probes
  broad kernel function wildcards.  (PR2725)

- An upstream kernel commit #2062afb4f804a put "-fno-var-tracking-assignments"
  into KCFLAGS, dramatically reducing debuginfo quality, which can cause
  debuginfo failures. The simplest fix is to erase, excise, nay, eradicate
  this line from the top level linux Makefile:

  KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)


= Coming soon

- prometheus-exporter is here, more tasty systemtap & http chocolate en route


= Contributors for this release

Aaron Merey, David Smith, Frank Ch. Eigler, Jafeer Uddin, Martin Cermak,
Masanari Iida, *Paulo Andrade, Serhei Makarov, Stan Cox, Victor Kamensky,
William Cohen, Yichun Zhang (agentzh), *Zexuan Luo

Special thanks to new contributors, marked with '*' above.
Special thanks to Serhei Makarov for assembling these notes.


= Bugs fixed for this release <https://sourceware.org/PR#####>

14690 the syscall tapsets could be written to prefer the 'syscalls' tracepoints
21888 bpf variants of log()/etc. functions
22310 build parser syntax for all the new staptree types
23160 4.17 breaks syscalls tapset
23284 dmesg should identify the name of the stap script
23356 server.exp test case hangs on rawhide
23359 impose security constraints on @kderef, @kregister
23407 bpf: backend should support strings as first class values
23480 bpfinterp.cxx should respond to ^C
23488 support CONFIG_DEBUG_INFO_REDUCED builds
23510 Tapset function println() not supported in the bpf runtime
23599 Use of usymname() with stap -u leads to kernel module compilation errors
23608 long stapregex overflows arc_priority
23666 Aggregate operations specified in foreach loop is not respected by the translator
23736 rawhide 4.19 kernel panic during tracepoint enumeration
23760 .statement() wildcard probes fail if any cu/srcfile lacks debug_line data
23766 staprun -R (default) fails for modules with short hardcoded -m names

