Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeEMInd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:43:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64200 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:43:32 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <doug.smythies@gmail.com>,
        srinivas.pandruvada@linux.intel.com
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
Date: Sun, 13 May 2018 10:43:02 +0200
Message-ID: <23851272.hyr4RImLsD@aspire.rjw.lan>
In-Reply-To: <1525441582-23855-1-git-send-email-dsmythies@telus.net>
References: <1525441582-23855-1-git-send-email-dsmythies@telus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 4, 2018 3:46:22 PM CEST Doug Smythies wrote:
> Allow the user to override the default trace buffer memory allocation
> by adding a command line option to override the default.
> 
> The patch also:
> 
> Adds a SIGINT (i.e. CTRL C exit) handler,
> so that things can be cleaned up before exit.
> 
> Moves the postion of some other cleanup from after to
> before the potential "No valid data to plot" exit.
> 
> Replaces all quit() calls with sys.exit, because
> quit() is not supposed to be used in scripts.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

Srinivas, any comments here?

> ---
>  .../x86/intel_pstate_tracer/intel_pstate_tracer.py | 54 ++++++++++++++--------
>  1 file changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 29f50d4..84e2b64 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -28,6 +28,7 @@ import subprocess
>  import os
>  import time
>  import re
> +import signal
>  import sys
>  import getopt
>  import Gnuplot
> @@ -78,11 +79,12 @@ def print_help():
>      print('    Or')
>      print('      ./intel_pstate_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>')
>      print('    To generate trace file, parse and plot, use (sudo required):')
> -    print('      sudo ./intel_pstate_tracer.py [-c cpus] -i <interval> -n <test_name>')
> +    print('      sudo ./intel_pstate_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>')
>      print('    Or')
> -    print('      sudo ./intel_pstate_tracer.py [--cpu cpus] --interval <interval> --name <test_name>')
> +    print('      sudo ./intel_pstate_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>')
>      print('    Optional argument:')
> -    print('      cpus:  comma separated list of CPUs')
> +    print('      cpus:   comma separated list of CPUs')
> +    print('      kbytes: Kilo bytes of memory per CPU to allocate to the trace buffer. Default: 10240')
>      print('  Output:')
>      print('    If not already present, creates a "results/test_name" folder in the current working directory with:')
>      print('      cpu.csv - comma seperated values file with trace contents and some additional calculations.')
> @@ -379,7 +381,7 @@ def clear_trace_file():
>          f_handle.close()
>      except:
>          print('IO error clearing trace file ')
> -        quit()
> +        sys.exit(2)
>  
>  def enable_trace():
>      """ Enable trace """
> @@ -389,7 +391,7 @@ def enable_trace():
>                   , 'w').write("1")
>      except:
>          print('IO error enabling trace ')
> -        quit()
> +        sys.exit(2)
>  
>  def disable_trace():
>      """ Disable trace """
> @@ -399,17 +401,17 @@ def disable_trace():
>                   , 'w').write("0")
>      except:
>          print('IO error disabling trace ')
> -        quit()
> +        sys.exit(2)
>  
>  def set_trace_buffer_size():
>      """ Set trace buffer size """
>  
>      try:
> -       open('/sys/kernel/debug/tracing/buffer_size_kb'
> -                 , 'w').write("10240")
> +       with open('/sys/kernel/debug/tracing/buffer_size_kb', 'w') as fp:
> +          fp.write(memory)
>      except:
> -        print('IO error setting trace buffer size ')
> -        quit()
> +       print('IO error setting trace buffer size ')
> +       sys.exit(2)
>  
>  def free_trace_buffer():
>      """ Free the trace buffer memory """
> @@ -418,8 +420,8 @@ def free_trace_buffer():
>         open('/sys/kernel/debug/tracing/buffer_size_kb'
>                   , 'w').write("1")
>      except:
> -        print('IO error setting trace buffer size ')
> -        quit()
> +        print('IO error freeing trace buffer ')
> +        sys.exit(2)
>  
>  def read_trace_data(filename):
>      """ Read and parse trace data """
> @@ -431,7 +433,7 @@ def read_trace_data(filename):
>          data = open(filename, 'r').read()
>      except:
>          print('Error opening ', filename)
> -        quit()
> +        sys.exit(2)
>  
>      for line in data.splitlines():
>          search_obj = \
> @@ -489,10 +491,22 @@ def read_trace_data(filename):
>  # Now seperate the main overall csv file into per CPU csv files.
>      split_csv()
>  
> +def signal_handler(signal, frame):
> +    print(' SIGINT: Forcing cleanup before exit.')
> +    if interval:
> +        disable_trace()
> +        clear_trace_file()
> +        # Free the memory
> +        free_trace_buffer()
> +        sys.exit(0)
> +
> +signal.signal(signal.SIGINT, signal_handler)
> +
>  interval = ""
>  filename = ""
>  cpu_list = ""
>  testname = ""
> +memory = "10240"
>  graph_data_present = False;
>  
>  valid1 = False
> @@ -501,7 +515,7 @@ valid2 = False
>  cpu_mask = zeros((MAX_CPUS,), dtype=int)
>  
>  try:
> -    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:",["help","trace_file=","interval=","cpu=","name="])
> +    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
>  except getopt.GetoptError:
>      print_help()
>      sys.exit(2)
> @@ -521,6 +535,8 @@ for opt, arg in opts:
>      elif opt in ("-n", "--name"):
>          valid2 = True
>          testname = arg
> +    elif opt in ("-m", "--memory"):
> +        memory = arg
>  
>  if not (valid1 and valid2):
>      print_help()
> @@ -569,6 +585,11 @@ current_max_cpu = 0
>  
>  read_trace_data(filename)
>  
> +clear_trace_file()
> +# Free the memory
> +if interval:
> +    free_trace_buffer()
> +
>  if graph_data_present == False:
>      print('No valid data to plot')
>      sys.exit(2)
> @@ -593,9 +614,4 @@ for root, dirs, files in os.walk('.'):
>      for f in files:
>          fix_ownership(f)
>  
> -clear_trace_file()
> -# Free the memory
> -if interval:
> -    free_trace_buffer()
> -
>  os.chdir('../../')
> 
