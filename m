Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDYXJt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:09:49 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39936 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbeDYXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:09:48 -0400
X-Google-Smtp-Source: AB8JxZoIouNeutfVRUVYmN9y1+/RoWl1YKIabHyIk3klIsTRYhy0dTFxwVH0oqQh1yXUbyxdAxGArA==
Date: Thu, 26 Apr 2018 02:09:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: #pragma once
Message-ID: <20180425230943.GA10728@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up with negative LOC trend...

	16171 files changed, 16197 insertions(+), 87671 deletions(-)

Not all files can be blindly converted as some headers check for master
header include guard (spinlock.h et al).

include/uapi/ can be skipped probably out of fear of finding a C compiler
without "#pragma once" support.

Script modifies files in place and gives up if something goes wrong even
slightly.

Use "#pragma once" in you code today!


#!/usr/bin/python2
# Change include guard to "#pragma once" directive in place.
import os
import re
import sys

re_ifndef = re.compile('#ifndef ([A-Za-z_][A-Za-z0-9_]*)\n')
re_define = re.compile('#define ([A-Za-z_][A-Za-z0-9_]*)\n')
re_endif  = re.compile('#endif([ \t]*/\*[^/]*\*/[ \t]*)?\n')

def read_file(filename):
    with open(filename) as f:
        buf = f.read()
    return buf

def write_file(filename, buf, chop_list):
    # [start, end)
    s1, e1 = chop_list[0]
    s2, e2 = chop_list[1]

    tmp = '%s.pragma-once' % filename
    with open(tmp, 'w') as f:
        f.write(buf[0:s1])
        if s1 > 0 and buf[s1 - 1] != '\n':
            f.write('\n')
        f.write('#pragma once\n')
        f.write(buf[e1:s2])
        if buf[s2 - 1] != '\n':
            f.write('\n')

    os.rename(tmp, filename)

def ws(c):
    return c == '\n' or c == ' ' or c == '\t'

def pragma_once(filename):
    c = read_file(filename)

    chop_list = []

    i = 0
    j = len(c)
    while i < j:
        if ws(c[i]):
            i = i + 1
        elif c[i] == '/' and c[i + 1] == '/':
            i = c.index('\n', i + 2) + 1
        elif c[i] == '/' and c[i + 1] == '*':
            i = c.index('*/', i + 2) + 2
        else:
            break

    ii = i;
    #ifndef
    match = re_ifndef.match(c, ii)
    if match is None:
        return
    guard = match.group(1)
    ii = match.end()

    #define
    match = re_define.match(c, ii)
    if match is None:
        return
    if guard != match.group(1):
        return
    ii = match.end()

    while i > 0 and ws(c[i - 1]):
        i = i - 1
    while ws(c[ii]):
        ii = ii + 1

    chop_list.append((i, ii))

    #endif
    ii = c.rindex("\n#endif", i) + 1
    match = re_endif.match(c, ii)
    if match is None:
        return
    jj = match.end()
    if jj != len(c):
        return

    while ws(c[ii - 1]):
        ii = ii - 1

    chop_list.append((ii, len(c)))

    write_file(filename, c, chop_list)

for filename in sys.argv[1:]:
    try:
        pragma_once(filename)
    except:
        pass
